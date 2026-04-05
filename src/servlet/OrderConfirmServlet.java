package servlet;

import model.Order;
import model.User;
import service.OrderService;
import service.UserService; // 导入UserService（确保和OrderService同包，路径正确）
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "order_confirm",urlPatterns = "/order_confirm")
public class OrderConfirmServlet extends HttpServlet {
    // 原有：声明OrderService实例
    private OrderService oService = new OrderService();
    // 新增：声明UserService实例（修复"找不到uService"报错）
    private UserService uService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 从session获取订单对象
        Order o = (Order) request.getSession().getAttribute("order");
        // 保存原价（用于前端展示）
        float originalTotal = o.getTotal();

        // ===== 新增：双十一满减计算（核心逻辑）=====
        float discount = 0; // 满减金额
        if (originalTotal >= 200) {
            discount = 50; // 满200减50
        } else if (originalTotal >= 100) {
            discount = 20; // 满100减20
        }
        // 更新订单最终支付金额
        float finalTotal = originalTotal - discount;
        o.setTotal(finalTotal);

        // 2. 手动赋值非时间字段（替代BeanUtils，避免时间转换错）
        o.setName(request.getParameter("name"));
        o.setPhone(request.getParameter("phone"));
        o.setAddress(request.getParameter("address"));
        o.setPaytype(Integer.parseInt(request.getParameter("paytype")));

        // 3. 手动处理配送方式+取货时间（核心！）
        String deliveryType = request.getParameter("deliveryType");
        String pickupTimeStr = request.getParameter("pickupTime");
        // 接收备注参数
        String remark = request.getParameter("remark");
        Date pickupTime = null;

        // ===== 新增：自取时强制校验取货时间 =====
        if ("自取".equals(deliveryType) && (pickupTimeStr == null || pickupTimeStr.trim().isEmpty())) {
            // 自取但没填时间，返回页面提示
            request.setAttribute("errorMsg", "自取必须填写取货时间！");
            request.getRequestDispatcher("/order_submit.jsp").forward(request, response);
            return; // 终止后续逻辑，避免报错
        }

        // 处理取货时间：前端传的是yyyy-MM-dd'T'HH:mm，要转成Date
        if (pickupTimeStr != null && !pickupTimeStr.trim().isEmpty()) {
            try {
                // 匹配datetime-local的格式（带T）
                pickupTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(pickupTimeStr);
            } catch (ParseException e) {
                e.printStackTrace();
                // ===== 新增：解析失败返回提示 =====
                request.setAttribute("errorMsg", "取货时间格式错误！请选择正确的时间");
                request.getRequestDispatcher("/order_submit.jsp").forward(request, response);
                return;
            }
        }

        // 4. 给订单赋值
        o.setDeliveryType(deliveryType);
        o.setPickupTime(pickupTime);
        // 赋值备注
        o.setRemark(remark);
        o.setDatetime(new Date()); // 订单创建时间
        o.setStatus(2); // 已付款状态
        o.setUser((User) request.getSession().getAttribute("user"));

        // 5. 调用service保存订单（原有逻辑，保持不变）
        oService.addOrder(o);

        // ===== 新增：积分累计（修复所有报错，贴合原有逻辑，补充2行核心代码）=====
        // 1. 从Session获取用户（修正key为"user"，避免loginUser为null）
        User loginUser = (User) request.getSession().getAttribute("user");
        // 2. 非空判断（避免空指针异常）
        if (loginUser != null) {
            Integer userId = loginUser.getId(); // 获取当前登录用户ID
            int addPoints = (int) finalTotal; // 计算积分：实付金额转int，1元1分（向下取整）
            uService.updateUserPoints(userId, addPoints); // 调用UserService更新积分（数据库层面）

            // 【补充1：同步更新Session中的用户积分（保证积分商城/后续页面实时显示最新积分）】
            loginUser.setPoints(loginUser.getPoints() + addPoints);
            request.getSession().setAttribute("user", loginUser);

            // 【补充2：将此次获得的积分存入request域（供order_success.jsp页面展示）】
            request.setAttribute("integralGained", addPoints);
        }

        // 原有逻辑：移除session中的订单
        request.getSession().removeAttribute("order");

        // 6. 跳转成功页（提示满减信息，原有逻辑，保持不变）
        request.setAttribute("msg", "订单支付成功！双十一满减优惠¥" + discount + "，原价¥" + originalTotal + "，实付¥" + finalTotal);
        request.getRequestDispatcher("/order_success.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
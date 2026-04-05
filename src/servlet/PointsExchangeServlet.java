package servlet; // 贴合你的项目，servlet包下

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User; // 你的User实体类
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils; // 你的数据库工具类
import java.sql.SQLException;

@WebServlet("/points_exchange")
public class PointsExchangeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. 编码设置
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 2. 获取session和用户信息
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/user_login.jsp");
            return;
        }
        Integer userId = user.getId();
        Integer userPoints = user.getPoints(); // 当前用户积分

        // 3. 获取兑换商品ID
        String goodsIdStr = request.getParameter("goodsId");
        if (goodsIdStr == null || goodsIdStr.isEmpty()) {
            request.setAttribute("failMsg", "兑换商品不存在！");
            request.getRequestDispatcher("/points_mall.jsp").forward(request, response);
            return;
        }
        Integer goodsId = Integer.parseInt(goodsIdStr);

        // 4. 查询兑换商品所需积分（适配你的QueryRunner风格，无DBUtil）
        Integer needPoints = null;
        try {
            QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
            String sql = "SELECT points_need FROM points_goods WHERE id = ?";
            needPoints = r.query(sql, new ScalarHandler<Integer>(), goodsId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 5. 校验商品和积分
        if (needPoints == null) {
            request.setAttribute("failMsg", "兑换商品不存在！");
            request.getRequestDispatcher("/points_mall.jsp").forward(request, response);
            return;
        }
        if (userPoints < needPoints) {
            request.setAttribute("failMsg", "积分不足！当前积分：" + userPoints + "，所需积分：" + needPoints);
            request.getRequestDispatcher("/points_mall.jsp").forward(request, response);
            return;
        }

        // 6. 扣除用户积分（更新user表，适配你的QueryRunner风格，无DBUtil）
        try {
            QueryRunner r = new QueryRunner(DataSourceUtils.getDataSource());
            // 关键修改：用反引号包裹user表名，避免与MySQL关键字冲突
            String updateSql = "UPDATE `user` SET points = points - ? WHERE id = ?";
            int rows = r.update(updateSql, needPoints, userId);
            if (rows > 0) {
                // 7. 更新session中的用户积分（刷新页面显示最新积分）
                user.setPoints(userPoints - needPoints);
                session.setAttribute("user", user);
                request.setAttribute("msg", "兑换成功！已扣除" + needPoints + "积分");
            } else {
                request.setAttribute("failMsg", "兑换失败，请重试！");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 可查看Tomcat日志获取具体异常信息
            request.setAttribute("failMsg", "兑换失败，数据库异常！");
        }

        // 8. 跳转回积分兑换商城
        request.getRequestDispatcher("/points_mall.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %> <%-- 新增：确保EL表达式生效 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>积分兑换商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link type="text/css" rel="stylesheet" href="css/bootstrap.css">
  <link type="text/css" rel="stylesheet" href="css/style.css">
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>

  <!-- 粉色系样式，与全站统一 -->
  <style type="text/css">
    /* 原有样式保留不变，新增未登录提示样式 */
    body {
      background: linear-gradient(120deg, #fff0f5 0%, #ffe6f2 100%) !important;
      font-family: "Microsoft YaHei", 幼圆, Arial, sans-serif;
    }
    .points-mall {
      padding: 60px 0;
    }
    .mall-container {
      background-color: #fff8fa !important;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0 6px 20px rgba(255, 182, 193, 0.3) !important;
    }
    .user-points {
      text-align: center;
      margin-bottom: 30px;
      color: #e66788 !important;
      font-size: 18px;
      background-color: #ffe6f2;
      padding: 15px;
      border-radius: 15px;
    }
    .user-points span {
      font-size: 24px;
      font-weight: bold;
      color: #d16088;
    }
    .mall-title {
      color: #e66788 !important;
      text-align: center;
      font-size: 26px;
      margin-bottom: 30px;
      text-shadow: 1px 1px 2px rgba(255, 105, 180, 0.2);
    }
    .goods-card {
      border: 2px solid #ffd6e0 !important;
      border-radius: 15px !important;
      padding: 20px;
      text-align: center;
      margin-bottom: 30px;
      transition: all 0.3s ease;
    }
    .goods-card:hover {
      box-shadow: 0 6px 15px rgba(255, 153, 187, 0.4) !important;
      transform: translateY(-5px);
    }
    .goods-img {
      width: 200px;
      height: 200px;
      object-fit: cover;
      border-radius: 10px;
      margin: 0 auto 15px;
    }
    .goods-name {
      color: #e66788 !important;
      font-size: 18px;
      margin-bottom: 10px;
    }
    .goods-points {
      color: #d16088 !important;
      font-weight: bold;
      margin-bottom: 15px;
    }
    .goods-desc {
      color: #666;
      font-size: 14px;
      margin-bottom: 20px;
    }
    .exchange-btn {
      background-color: #ff99bb !important;
      border: none !important;
      border-radius: 15px !important;
      color: #fff !important;
      padding: 10px 30px !important;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.3s ease;
    }
    .exchange-btn:hover {
      background-color: #e66788 !important;
      box-shadow: 0 4px 8px rgba(255, 105, 180, 0.3) !important;
    }
    /* 新增：禁用/未登录提示按钮样式 */
    .exchange-btn-disabled {
      background-color: #ffd6e0 !important;
      border: none !important;
      border-radius: 15px !important;
      color: #d16088 !important;
      padding: 10px 30px !important;
      font-size: 16px;
      cursor: not-allowed;
      opacity: 0.8;
    }
    .alert {
      border: none !important;
      border-radius: 15px !important;
      text-align: center;
      box-shadow: 0 2px 10px rgba(255, 182, 193, 0.2) !important;
      margin-bottom: 20px;
    }
    .alert-success {
      background-color: #ffe6f2 !important;
      color: #e66788 !important;
    }
    .alert-danger {
      background-color: #ffd6e0 !important;
      color: #d16088 !important;
    }
    /* 新增：未登录提示文字样式 */
    .login-tip {
      color: #d16088;
      font-size: 14px;
      margin-top: 10px;
    }
  </style>
</head>
<body>
<!-- 导航栏 -->
<jsp:include page="/header.jsp">
  <jsp:param value="11" name="flag"/>
</jsp:include>

<%-- 【修改1：移除未登录强制重定向代码】不再直接跳登录页 --%>
<%-- 原来的代码：
<c:if test="${empty user}">
    <% response.sendRedirect("/user_login.jsp"); %>
</c:if>
--%>

<!-- 积分兑换商城主体 -->
<div class="points-mall">
  <div class="container">
    <div class="mall-container">
      <h2 class="mall-title">积分兑换商城</h2>

      <!-- 提示框 -->
      <c:if test="${!empty msg}">
        <div class="alert alert-success">${msg}</div>
      </c:if>
      <c:if test="${!empty failMsg}">
        <div class="alert alert-danger">${failMsg}</div>
      </c:if>

      <!-- 【修改2：区分显示个人积分】已登录显示积分，未登录隐藏/提示 -->
      <c:if test="${!empty user}">
        <!-- 已登录：显示当前可用积分 -->
        <div class="user-points">
          当前可用积分：<span>${user.points}</span> 分
        </div>
      </c:if>
      <c:if test="${empty user}">
        <!-- 未登录：显示登录提示 -->
        <div class="user-points">
          请<a href="/user_login.jsp" style="color: #e66788; font-weight: bold;">登录</a>后查看并使用个人积分
        </div>
      </c:if>

      <!-- 商品列表（两行一列，适配移动端） -->
      <div class="goods-card">
        <!-- 图片标签：不受登录状态影响，未登录也会渲染 -->
        <img src="picture/15.jpg" class="goods-img" alt="草莓蛋糕">
        <h3 class="goods-name">草莓蛋糕（积分兑换）</h3>
        <p class="goods-points">所需积分：1000 分</p>
        <p class="goods-desc">纯动物奶油，新鲜草莓点缀，香甜软糯</p>

        <!-- 只有兑换按钮受登录状态影响，图片不受影响 -->
        <c:if test="${!empty user}">
          <form action="/points_exchange" method="post">
            <input type="hidden" name="goodsId" value="1">
            <button type="submit" class="exchange-btn">立即兑换</button>
          </form>
        </c:if>
        <c:if test="${empty user}">
          <button class="exchange-btn-disabled" disabled>立即兑换</button>
          <p class="login-tip">登录后即可兑换商品</p>
        </c:if>
      </div>
        </div>

        <!-- 500积分 泡芙 -->
        <div class="col-md-6 col-sm-12">
          <div class="goods-card">
            <img src="picture/16.jpg" class="goods-img" alt="奶油泡芙">            <h3 class="goods-name">奶油泡芙</h3>
            <p class="goods-points">所需积分：500 分</p>
            <p class="goods-desc">酥脆外皮，内馅饱满，一口爆浆</p>

            <!-- 【修改3：区分显示兑换按钮】已登录显示可点击按钮，未登录显示禁用按钮+提示 -->
            <c:if test="${!empty user}">
              <!-- 已登录：正常显示兑换表单 -->
              <form action="/points_exchange" method="post">
                <input type="hidden" name="goodsId" value="2">
                <button type="submit" class="exchange-btn">立即兑换</button>
              </form>
            </c:if>
            <c:if test="${empty user}">
              <!-- 未登录：显示禁用按钮+登录提示 -->
              <button class="exchange-btn-disabled" disabled>立即兑换</button>
              <p class="login-tip">登录后即可兑换商品</p>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 页脚 -->
<jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> <%-- 新增：确保EL表达式生效，解析${integralGained} --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>支付成功</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.css">
	<link type="text/css" rel="stylesheet" href="css/style.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	<script type="text/javascript" src="js/cart.js"></script>
	<style type="text/css">
		/* 新增：积分提示样式，贴合粉色系，兼容原有Bootstrap */
		.alert-integral {
			color: #d16088;
			background-color: #ffe6f2;
			border-color: #ffd6e0;
		}
		.alert-integral a {
			color: #e66788;
			font-weight: bold;
			text-decoration: none;
		}
		.alert-integral a:hover {
			color: #c55078;
			text-decoration: underline;
		}
	</style>
</head>
<body>

<!--header-->
<jsp:include page="header.jsp"></jsp:include>
<!--//header-->


<!--cart-items-->
<div class="cart-items">
	<div class="container">

		<!-- 原有：订单成功提示 -->
		<c:if test="${!empty msg }">
			<div class="alert alert-success">${msg }</div>
		</c:if>

		<!-- 新增：积分到账提示（仅当获得积分时显示，与原有提示并列） -->
		<c:if test="${!empty integralGained}">
			<div class="alert alert-integral">
				🎉 积分到账！此次获得 <strong>${integralGained}</strong> 积分，可前往<a href="/points_mall.jsp">积分商城</a>兑换精美商品~
			</div>
		</c:if>

		<!-- 原有：查看订单按钮 -->
		<p><a class="btn btn-success" href="/order_list">查看我的订单</a></p>

		<!-- 可选：新增“前往积分商城”按钮，提升引导性 -->
		<p style="margin-top: 10px;">
			<a class="btn btn-primary" href="/points_mall.jsp" style="background-color: #ff99bb; border-color: #ff99bb;">
				前往积分商城
			</a>
		</p>
	</div>
</div>
<!--//cart-items-->

<!--footer-->
<jsp:include page="footer.jsp"></jsp:include>
<!--//footer-->

</body>
</html>
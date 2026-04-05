<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>个人中心</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.css">
	<link type="text/css" rel="stylesheet" href="css/style.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/simpleCart.min.js"></script>

	<!-- 新增：与全站统一的甜美粉色系样式 -->
	<style type="text/css">
		/* 页面背景，与导航栏渐变一致 */
		body {
			background: linear-gradient(120deg, #fff0f5 0%, #ffe6f2 100%) !important;
			font-family: "Microsoft YaHei", 幼圆, Arial, sans-serif;
		}

		/* 个人中心容器样式，柔和粉色质感 */
		.account {
			padding: 60px 0;
		}
		.register {
			background-color: #fff8fa !important;
			padding: 40px;
			border-radius: 20px;
			box-shadow: 0 6px 20px rgba(255, 182, 193, 0.3) !important;
		}

		/* 标题样式，与全站文字色统一 */
		.register-top-grid h3 {
			color: #e66788 !important;
			text-align: center;
			font-size: 26px;
			margin-bottom: 30px;
			text-shadow: 1px 1px 2px rgba(255, 105, 180, 0.2);
		}
		.register-top-grid h4 {
			color: #d16088 !important;
			font-size: 18px;
			margin: 20px 0 15px;
			border-left: 4px solid #ff99bb;
			padding-left: 10px;
		}

		/* 输入框样式，粉色边框+圆角 */
		.input input {
			border: 2px solid #ffd6e0 !important;
			border-radius: 15px !important;
			padding: 12px 15px !important;
			color: #d16088 !important;
			width: 100%;
			box-shadow: none !important;
			transition: all 0.3s ease;
		}
		.input input::placeholder {
			color: #ffb6c1 !important;
			opacity: 0.8;
		}
		.input input:focus {
			border-color: #ff99bb !important;
			box-shadow: 0 0 8px rgba(255, 153, 187, 0.4) !important;
			outline: none !important;
		}

		/* 提交按钮样式，与全站按钮配色统一 */
		.register-but input[type="submit"] {
			background-color: #ff99bb !important;
			border: none !important;
			border-radius: 15px !important;
			color: #fff !important;
			padding: 12px 40px !important;
			font-size: 16px;
			transition: all 0.3s ease;
			cursor: pointer;
		}
		.register-but input[type="submit"]:hover {
			background-color: #e66788 !important;
			box-shadow: 0 4px 8px rgba(255, 105, 180, 0.3) !important;
			transform: translateY(-2px);
		}

		/* 分割线样式，融入粉色系 */
		hr {
			border-top: 1px solid #ffd6e0 !important;
			margin: 25px 0;
		}

		/* 提示框样式优化，与全站风格统一 */
		.alert {
			border: none !important;
			border-radius: 15px !important;
			text-align: center;
			box-shadow: 0 2px 10px rgba(255, 182, 193, 0.2) !important;
		}
		.alert-success {
			background-color: #ffe6f2 !important;
			color: #e66788 !important;
		}
		.alert-danger {
			background-color: #ffd6e0 !important;
			color: #d16088 !important;
		}
	</style>
</head>
<body>

<jsp:include page="/header.jsp">
	<jsp:param value="4" name="flag"/>
</jsp:include>
<c:if test="${empty user}"><%response.sendRedirect("/index");%></c:if>
<!--account-->
<div class="account">
	<div class="container">
		<div class="register">
			<c:if test="${!empty msg }">
				<div class="alert alert-success">${msg }</div>
			</c:if>
			<c:if test="${!empty failMsg }">
				<div class="alert alert-danger">${failMsg }</div>
			</c:if>

			<div class="register-top-grid">
				<h3>个人中心</h3>
				<form action="/user_changeaddress" method="post">
					<!-- 收货信息 start -->
					<h4>收货信息</h4>
					<div class="input">
						<span>收货人<label></label></span>
						<input type="text" name="name" value="${user.name }" placeholder="请输入收货">
					</div>
					<div class="input">
						<span>收货电话</span>
						<input type="text" name="phone" value="${user.phone }" placeholder="请输入收货电话">
					</div>
					<div class="input">
						<span>收货地址</span>
						<input type="text" name="address" value="${user.address }" placeholder="请输入收货地址">
					</div>
					<div class="register-but text-center">
						<input type="submit" value="提交">
					</div>
					<!-- 收货信息 end -->
				</form>
				<hr>
				<form action="/user_changepwd" method="post">
					<h4>安全信息</h4>
					<div class="input">
						<span>原密码</span>
						<input type="text" name="password" placeholder="请输入原密码">
					</div>
					<div class="input">
						<span>新密码</span>
						<input type="text" name="newPassword" placeholder="请输入新密码">
					</div>
					<div class="clearfix"> </div>
					<div class="register-but text-center">
						<input type="submit" value="提交">
					</div>
				</form>
			</div>

			<div class="clearfix"> </div>
		</div>
	</div>
</div>
<!--//account-->




<jsp:include page="/footer.jsp"></jsp:include>


</body>
</html>
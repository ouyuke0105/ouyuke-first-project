<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<title>用户登录</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.css">
	<link type="text/css" rel="stylesheet" href="css/style.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/simpleCart.min.js"></script>

	<!-- 新增：与导航栏统一的粉色系样式（覆盖原有默认样式） -->
	<style type="text/css">
		/* 页面整体背景，与导航栏呼应 */
		body {
			background: linear-gradient(120deg, #fff0f5 0%, #ffe6f2 100%) !important;
			font-family: "Microsoft YaHei", 幼圆, Arial, sans-serif;
		}

		/* 登录容器样式优化，柔和粉色质感 */
		.account {
			padding: 60px 0;
		}
		.register {
			background-color: #fff8fa !important;
			padding: 40px;
			border-radius: 20px;
			box-shadow: 0 6px 20px rgba(255, 182, 193, 0.3) !important;
		}

		/* 登录标题样式，与导航栏文字色统一 */
		.register-top-grid h3 {
			color: #e66788 !important;
			text-align: center;
			font-size: 24px;
			margin-bottom: 30px;
			text-shadow: 1px 1px 2px rgba(255, 105, 180, 0.2);
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

		/* 提交按钮样式，与导航栏按钮配色统一 */
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

		/* 提示框样式优化，融入粉色系 */
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
<!--header-->
<jsp:include page="header.jsp">
	<jsp:param name="flag" value="9"></jsp:param>
</jsp:include>
<!--//header-->

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

			<form action="/user_login" method="post">
				<div class="register-top-grid">
					<h3>用户登录</h3>
					<div class="input">
						<span>用户名/邮箱 <label style="color:red;">*</label></span>
						<input type="text" name="ue" placeholder="请输入用户名" required="required">
					</div>
					<div class="input">
						<span>密码 <label style="color:red;">*</label></span>
						<input type="password" name="password" placeholder="请输入密码" required="required">
					</div>

					<div class="clearfix"> </div>
				</div>
				<div class="register-but text-center">
					<input type="submit" value="提交">
					<div class="clearfix"> </div>
				</div>
			</form>
			<div class="clearfix"> </div>
		</div>
	</div>
</div>
<!--//account-->

<!--footer-->
<jsp:include page="footer.jsp"></jsp:include>
<!--//footer-->
</body>
</html>
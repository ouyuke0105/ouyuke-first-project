<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>支付</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.css">
	<link type="text/css" rel="stylesheet" href="css/style.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	<script type="text/javascript" src="js/cart.js"></script>
</head>
<body>

<!--header-->
<jsp:include page="header.jsp"></jsp:include>
<!--//header-->

<div class="cart-items">
	<div class="container">
		<h2>确认收货信息</h2>
		<form class="form-horizontal" action="/order_confirm" method="post" id="payform">
			<div class="row">
				<label class="control-label col-md-1">收货人</label>
				<div class="col-md-6">
					<input type="text" class="form-control" name="name" value="${user.name }" style="height:auto;padding:10px;" placeholder="输入收货人" required="required"><br>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-1">收货电话</label>
				<div class="col-md-6">
					<input type="text" class="form-control" name="phone" value="${user.phone }" style="height:auto;padding:10px;" placeholder="输入收货电话" required="required"><br>
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-1">收货地址</label>
				<div class="col-md-6">
					<input type="text" class="form-control" name="address" value="${user.address }" style="height:auto;padding:10px;" placeholder="输入收货地址" required="required"><br>
				</div>
			</div>

			<div class="row">
				<label class="control-label col-md-1">配送方式</label>
				<div class="col-md-6" style="margin-top:8px;">
					<input type="radio" name="deliveryType" value="自取" checked> 自取
					<input type="radio" name="deliveryType" value="外卖" style="margin-left:20px;"> 外卖
				</div>
			</div>
			<div class="row">
				<label class="control-label col-md-1">取货时间</label>
				<div class="col-md-6">
					<input type="datetime-local" class="form-control" name="pickupTime" style="height:auto;padding:10px;" required>
					<span style="color:#999;font-size:12px;margin-top:5px;display:block;">自取必填，外卖可留空</span>
				</div>
			</div>

			<div class="row" style="margin-top:10px;">
				<label class="control-label col-md-1">备注</label>
				<div class="col-md-6">
					<textarea class="form-control" name="remark" rows="3" style="height:auto;padding:10px;" placeholder="比如：少糖、少奶油、尽快配送..."></textarea>
				</div>
			</div>

			<br><hr><br>

			<!--  双十一满减活动提示 -->
			<div style="background: #ff4444; color: white; padding: 12px; border-radius: 6px; margin-bottom: 20px; font-size: 16px;">
				🎉 双十一狂欢大促！满100减20，满200减50，优惠自动生效 🎉
			</div>

			<h2>选择支付方式</h2>
			<%-- 修复：从session获取订单（订单是存在session里的！） --%>
			<%
				float originalTotal = 0;
				// 从session中取order对象（和Servlet里的逻辑一致）
				model.Order order = (model.Order) session.getAttribute("order");
				if (order != null) {
					originalTotal = order.getTotal();
				}
				// 计算满减金额
				float discount = 0;
				if (originalTotal >= 200) {
					discount = 50;
				} else if (originalTotal >= 100) {
					discount = 20;
				}
				float finalTotal = originalTotal - discount;
			%>
			<h3>
				<% if (originalTotal > 0) { %>
				订单原价: ¥<%=originalTotal%>
				&nbsp;&nbsp;
				<span style="color: #ff4444; font-weight: bold; font-size: 18px;">
			            满减后金额: ¥<%=finalTotal%>
			        </span>
				<% if (discount > 0) { %>
				<span style="color: #666; font-size: 14px;">（立减¥<%=discount%>）</span>
				<% } %>
				<% } else { %>
				<span style="color: #999;">请先选择商品加入购物车~</span>
				<% } %>
			</h3><br><br>

			<div class="col-sm-6 col-md-4 col-lg-3 " >
				<label>
					<div class="thumbnail">
						<input type="radio" name="paytype" value="1" checked="checked" />
						<img src="images/wechat.jpg" alt="微信支付">
					</div>
				</label>】
			</div>
			<div class="col-sm-6 col-md-4 col-lg-3 " >
				<label>
					<div class="thumbnail">
						<input type="radio" name="paytype" value="2"  />
						<img src="images/alipay.jpg" alt="支付宝支付">
					</div>
				</label>
			</div>
			<div class="col-sm-6 col-md-4 col-lg-3 " >
				<label>
					<div class="thumbnail">
						<input type="radio" name="paytype" value="3"  />
						<img src="images/yhk.jpg" alt="银行卡支付">
					</div>
				</label>
			</div>
			<div class="clearfix"> </div>
			<div class="register-but text-center">
				<input type="submit" value="确认订单" <%= originalTotal <= 0 ? "disabled style='background:#ccc;'" : "" %>>
				<div class="clearfix"> </div>
			</div>
		</form>
	</div>
</div>

<!--footer-->
<jsp:include page="footer.jsp"></jsp:include>
<!--//footer-->

<script type="text/javascript">
	function dopay(paytype){
		$("#paytype").val(paytype);
		$("#payform").submit();
	}
</script>

</body>
</html>
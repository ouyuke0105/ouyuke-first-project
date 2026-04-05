<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 19767
  Date: 2018/11/23
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>

<!-- 新增：甜美风格样式（覆盖原有样式） -->
<style type="text/css">
    /* 全局基础样式 */
    body {
        font-family: "Microsoft YaHei", "幼圆", Arial, sans-serif; /* 圆润字体更甜美 */
    }
    /* 头部整体背景 */
    .header {
        background: linear-gradient(120deg, #fff0f5 0%, #ffe6f2 100%); /* 浅粉渐变背景 */
        padding: 10px 0;
        box-shadow: 0 2px 10px rgba(255, 182, 193, 0.3); /* 柔和粉色阴影 */
    }
    /* 导航栏样式重置 */
    .navbar-default {
        background-color: transparent;
        border: none;
        margin-bottom: 0;
    }
    /* 品牌logo区域 */
    .navbar-brand {
        height: auto;
        padding: 5px 0;
    }
    .navbar-brand a {
        display: block;
        width: 120px;
        height: 50px;
        background: url("images/logo.png") no-repeat center; /* 可替换成甜美风logo */
        background-size: contain;
        font-size: 24px;
        color: #e66788 !important; /* 甜莓粉 */
        font-weight: bold;
        text-shadow: 1px 1px 2px rgba(255, 105, 180, 0.2);
    }
    /* 导航菜单 */
    .nav > li > a {
        color: #d16088 !important; /* 豆沙粉 */
        font-size: 16px;
        padding: 15px 20px;
        border-radius: 20px; /* 圆润圆角 */
        margin: 0 5px;
        transition: all 0.3s ease;
    }
    .nav > li > a:hover, .nav > li > a.active {
        background-color: #ffc2d1 !important; /* 浅桃粉 */
        color: #fff !important;
        box-shadow: 0 4px 8px rgba(255, 182, 193, 0.4);
        transform: translateY(-2px); /* 轻微上浮，更灵动 */
    }
    /* 下拉菜单样式 */
    .dropdown-menu {
        background-color: #fff8fa; /* 雪纺粉 */
        border: none;
        border-radius: 15px; /* 圆润圆角 */
        box-shadow: 0 6px 15px rgba(255, 182, 193, 0.3);
        padding: 15px;
        margin-top: 10px !important;
    }
    .dropdown-menu h4 {
        color: #e66788; /* 甜莓粉 */
        font-size: 18px;
        margin-bottom: 10px;
        border-bottom: 2px solid #ffd6e0;
        padding-bottom: 5px;
    }
    .multi-column-dropdown li a {
        color: #d16088; /* 豆沙粉 */
        padding: 8px 15px;
        border-radius: 10px;
        transition: all 0.2s ease;
    }
    .multi-column-dropdown li a:hover {
        background-color: #ffe6f2;
        color: #e66788;
        padding-left: 20px;
    }
    /* 搜索框区域 */
    .search-box {
        position: relative;
    }
    .search-box .glyphicon-search {
        color: #e66788;
        font-size: 18px;
        cursor: pointer;
    }
    .search .form-control {
        border: 2px solid #ffd6e0;
        border-radius: 20px 0 0 20px;
        padding: 8px 15px;
        color: #d16088;
        box-shadow: none;
    }
    .search .form-control:focus {
        border-color: #ff99bb;
        box-shadow: 0 0 8px rgba(255, 153, 187, 0.4);
    }
    .search .btn-default {
        background-color: #ff99bb;
        border: 2px solid #ff99bb;
        border-radius: 0 20px 20px 0;
        color: #fff;
        padding: 8px 20px;
        transition: all 0.3s ease;
    }
    .search .btn-default:hover, .search .btn-default.active {
        background-color: #e66788;
        border-color: #e66788;
        box-shadow: 0 4px 8px rgba(255, 105, 180, 0.3);
    }
    /* 购物车区域 */
    .cart a {
        position: relative;
        color: #e66788;
        font-size: 22px;
        transition: all 0.3s ease;
    }
    .cart a:hover {
        color: #ff6b9e;
        transform: scale(1.1); /* 轻微放大 */
    }
    .card_num {
        position: absolute;
        top: -8px;
        right: -8px;
        background-color: #ff6b9e;
        color: #fff;
        font-size: 12px;
        width: 20px;
        height: 20px;
        line-height: 20px;
        text-align: center;
        border-radius: 50%; /* 圆形数字标 */
        box-shadow: 0 2px 5px rgba(255, 105, 180, 0.4);
    }
    /* 响应式适配 */
    @media (max-width: 768px) {
        .nav > li > a {
            border-radius: 10px;
            padding: 10px 15px;
        }
        .dropdown-menu {
            border-radius: 10px;
        }
    }
</style>

<!--header-->
<div class="header">
    <div class="container">
        <nav class="navbar navbar-default" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar" style="background-color: #e66788;"></span>
                    <span class="icon-bar" style="background-color: #e66788;"></span>
                    <span class="icon-bar" style="background-color: #e66788;"></span>
                </button>
                <h1 class="navbar-brand"><a href="/index">甜莓小铺</a></h1> <!-- 替换成甜美店名 -->
            </div>
            <!--navbar-header-->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="/index" <c:if test="${param.flag==1}">class="active"</c:if>>首页</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle <c:if test="${param.flag==2}">active</c:if>" data-toggle="dropdown">商品分类<b class="caret" style="color: #e66788;"></b></a>
                        <ul class="dropdown-menu multi-column columns-2">
                            <li>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h4>✨ 商品分类 ✨</h4> <!-- 加可爱符号 -->
                                        <ul class="multi-column-dropdown">
                                            <li><a class="list" href="/goods_list">全部系列</a></li>
                                            <c:forEach items="${typeList}" var="t">
                                                <li><a class="list" href="/goods_list?typeid=${t.id}">${t.name}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li><a href="/goodsrecommend_list?type=2" <c:if test="${param.flag==3 && t==2}">class="active"</c:if>>热销🍓</a></li> <!-- 加可爱emoji -->
                    <li><a href="/goodsrecommend_list?type=3" <c:if test="${param.flag==3 && t==3}">class="active"</c:if>>新品🌸</a></li> <!-- 加可爱emoji -->
                    <!-- 新增：积分兑换商城导航入口 -->
                    <li <c:if test="${param.flag == 11}">class="active"</c:if>>
                        <a href="/points_mall.jsp">兑换商城🎁</a>
                    </li>

                    <c:choose>
                        <c:when test="${empty user }">
                            <li><a href="/user_register.jsp" <c:if test="${param.flag==10 }">class="active"</c:if>>注册💖</a></li> <!-- 加可爱emoji -->
                            <li><a href="/user_login.jsp" <c:if test="${param.flag==9 }">class="active"</c:if>>登录🔑</a></li> <!-- 加可爱emoji -->
                        </c:when>
                        <c:otherwise>
                            <li><a href="/order_list" <c:if test="${param.flag==5 }">class="active"</c:if>>我的订单📦</a></li> <!-- 加可爱emoji -->
                            <li><a href="/user_center.jsp" <c:if test="${param.flag==4 }">class="active"</c:if>>个人中心💓</a></li> <!-- 加可爱emoji -->
                            <li><a href="/user_logout" >退出🚪</a></li> <!-- 加可爱emoji -->
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${!empty user && user.isadmin }">
                        <li><a href="/admin/index.jsp" target="_blank" style="color: #ff6b9e !important;">后台管理⚙️</a></li>
                    </c:if>
                </ul>
                <!--/.navbar-collapse-->
            </div>
            <!--//navbar-header-->
        </nav>
        <div class="header-info">
            <div class="header-right search-box">
                <a href="javascript:;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></a>
                <div class="search">
                    <form class="navbar-form" action="/goods_search">
                        <input type="text" class="form-control" name="keyword" placeholder="搜索甜甜的好物～"> <!-- 甜美提示语 -->
                        <button type="submit" class="btn btn-default <c:if test="${param.flag==7 }">active</c:if>" aria-label="Left Align">搜索</button>
                    </form>
                </div>
            </div>

            <div class="header-right cart">
                <a href="goods_cart.jsp">
                    <span class="glyphicon glyphicon-shopping-cart <c:if test="${param.flag==8 }">active</c:if>" aria-hidden="true">
                        <span class="card_num"><c:choose><c:when test="${empty order}">0</c:when><c:otherwise>${order.amount}</c:otherwise></c:choose></span>
                    </span>
                </a>
            </div>
            <div class="clearfix"> </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<!--//header-->
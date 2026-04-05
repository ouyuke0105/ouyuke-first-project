package service;

import dao.GoodsDao;
import model.Goods;
import model.Page;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class GoodsService {
    // 保留你原有：DAO层实例化方式
    private GoodsDao gDao = new GoodsDao();

    // 保留你原有：获取推荐商品列表
    public List<Map<String, Object>> getGoodsList(int recommendType) {
        List<Map<String, Object>> list = null;
        try {
            list = gDao.getGoodsList(recommendType);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 保留你原有：获取轮播商品列表
    public List<Map<String, Object>> getScrollGood() {
        List<Map<String, Object>> list = null;
        try {
            list = gDao.getScrollGood();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 保留你原有：根据分类ID查询商品（带分页参数，核心方法，奶茶系列复用）
    public List<Goods> selectGoodsByTypeID(int typeID, int pageNumber, int pageSize) {
        List<Goods> list = null;
        try {
            list = gDao.selectGoodsByTypeID(typeID, pageNumber, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 保留你原有：根据分类ID查询分页对象（奶茶系列分页复用）
    public Page selectPageByTypeID(int typeID, int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int totalCount = 0;
        try {
            totalCount = gDao.getCountOfGoodsByTypeID(typeID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // 保留你原有：设置分页大小（8条/页）和总记录数（注意方法名大小写，贴合你的Page类）
        p.SetPageSizeAndTotalCount(8, totalCount);

        List list = null;
        try {
            list = gDao.selectGoodsByTypeID(typeID, pageNumber, 8);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        p.setList(list);
        return p;
    }

    // 保留你原有：获取推荐商品分页
    public Page getGoodsRecommendPage(int type, int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int totalCount = 0;
        try {
            totalCount = gDao.getRecommendCountOfGoodsByTypeID(type);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.SetPageSizeAndTotalCount(8, totalCount);
        List list = null;
        try {
            list = gDao.selectGoodsbyRecommend(type, pageNumber, 8);
            for (Goods g : (List<Goods>) list) {
                g.setScroll(gDao.isScroll(g));
                g.setHot(gDao.isHot(g));
                g.setNew(gDao.isNew(g));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.setList(list);
        return p;
    }

    // 保留你原有：根据商品ID查询详情
    public Goods getGoodsById(int id) {
        Goods g = null;
        try {
            g = gDao.getGoodsById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return g;
    }

    // 保留你原有：搜索商品分页
    public Page getSearchGoodsPage(String keyword, int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int totalCount = 0;
        try {
            totalCount = gDao.getSearchCount(keyword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.SetPageSizeAndTotalCount(8, totalCount);
        List list = null;
        try {
            list = gDao.selectSearchGoods(keyword, pageNumber, 8);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.setList(list);
        return p;
    }

    // 保留你原有：添加商品推荐
    public void addRecommend(int id, int type) {
        try {
            gDao.addRecommend(id, type);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 保留你原有：移除商品推荐
    public void removeRecommend(int id, int type) {
        try {
            gDao.removeRecommend(id, type);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 保留你原有：新增商品
    public void insert(Goods goods) {
        try {
            gDao.insert(goods);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 保留你原有：修改商品
    public void update(Goods goods) {
        try {
            gDao.update(goods);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 保留你原有：删除商品
    public void delete(int id) {
        try {
            gDao.delete(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ================ 新增：奶茶系列简化查询方法（可选，贴合Servlet调用，不破坏原有逻辑） ================
    /**
     * 简化查询：根据分类ID查询商品（默认第1页，8条/页，用于奶茶专属区域展示）
     * 奶茶系列传入typeId=12，直接复用原有selectGoodsByTypeID方法
     */
    public List<Goods> findGoodsByTypeId(int typeId) {
        // 复用你原有核心方法，默认第1页、每页8条，与分页配置一致
        return this.selectGoodsByTypeID(typeId, 1, 8);
    }
}
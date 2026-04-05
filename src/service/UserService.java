package service;

import dao.UserDao;
import model.Page;
import model.User;

import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDao uDao = new UserDao();
    public boolean register(User user) {
        try {
            if(uDao.isUsernameExist(user.getUsername())) {
                return false;
            }
            if(uDao.isEmailExist(user.getEmail())) {
                return false;
            }
            uDao.addUser(user);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User login(String ue,String password) {
        User user=null;
        try {
            user = uDao.selectByUsernamePassword(ue, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(user!=null) {
            return user;
        }
        try {
            user=uDao.selectByEmailPassword(ue, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(user!=null) {
            return user;
        }
        return null;
    }
    public User selectById(int id) {
        User u=null;
        try {
            u = uDao.selectById(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }
    public void updateUserAddress(User user) {
        try {
            uDao.updateUserAddress(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updatePwd(User user) {
        try {
            uDao.updatePwd(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Page getUserPage(int pageNumber) {
        Page p = new Page();
        p.setPageNumber(pageNumber);
        int pageSize = 7;
        int totalCount = 0;
        try {
            totalCount = uDao.selectUserCount();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.SetPageSizeAndTotalCount(pageSize, totalCount);
        List list=null;
        try {
            list = uDao.selectUserList( pageNumber, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        p.setList(list);
        return p;
    }
    public boolean delete(int id ) {
        try {
            uDao.delete(id);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ===== 新增：updateUserPoints方法（和Servlet中调用的方法完全匹配）=====
    public void updateUserPoints(Integer userId, int addPoints) {
        try {
            // 调用UserDao的updateUserPoints方法（下一步需在UserDao中补充）
            uDao.updateUserPoints(userId, addPoints);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
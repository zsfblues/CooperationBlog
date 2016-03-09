package com.zsf.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.zsf.dao.LoginSubmitImp;
import com.zsf.dao.SubmitContext;
import com.zsf.utils.MD5;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.javabean.User;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action
 * @ 2015/10/17
 */

public class LoginAction extends ActionSupport implements ModelDriven<User>
{
    private User user = new User();

    public String execute() throws Exception
    {
        SubmitContext<User> submitContext = new SubmitContext<>(new LoginSubmitImp(), user);

        if (submitContext.ContextSubmit("login_repeat_submit"))
        {
            String md5Password = MD5.GetMD5Code(user.getPassword());
            List<String[]> list = QueryHelper.executeQuery("select email, username, user_id from users where email = ? and password = ?", user.getUsername(), md5Password);

            if (list.size() != 0)
            {
                HttpSession session = ServletActionContext.getRequest().getSession();
                session.removeAttribute("loginerror");
                session.setAttribute("myemail", list.get(0)[0]);
                session.setAttribute("user", list.get(0)[1]);
                session.setAttribute("userId", list.get(0)[2]);

                return SUCCESS;
            }
            else
            {
                ServletActionContext.getRequest().setAttribute("loginerror", "密码错误或用户名不存在");
            }
        }

        return ERROR;
    }

    @Override
    public User getModel()
    {
        return user;
    }
}

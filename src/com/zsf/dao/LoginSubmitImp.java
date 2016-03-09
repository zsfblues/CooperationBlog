package com.zsf.dao;

import com.zsf.interfaces.Submit;
import com.zsf.javabean.User;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.dao
 * @ 2015/10/18
 */
public class LoginSubmitImp implements Submit<User>
{

    @Override
    public boolean isRepeatSubmit(String name)
    {
        HttpSession session = ServletActionContext.getRequest().getSession();
        String repeat_submit = (String) session.getAttribute(name);

        //为空，则表示此前未提交
        if (repeat_submit == null)
        {
            session.setAttribute(name, session.getId());
            session.removeAttribute(name);

            return true;
        }

        return false;
    }

    @Override
    public boolean checkInfoFormat(User user)
    {
        String username = user.getUsername();
        String password = user.getPassword();

        return !(username == null || password == null)
                && (username.length() != 0) && (password.length() != 0);
    }

}

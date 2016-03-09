package com.zsf.dao;

import com.opensymphony.xwork2.ModelDriven;
import com.zsf.interfaces.Submit;
import com.zsf.javabean.UserInfo;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.dao
 * @ 2015/10/18
 */
public class RegisterSubmitImp implements Submit<UserInfo>
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
    public boolean checkInfoFormat(UserInfo userInfo)
    {
        String email = userInfo.getEmail().trim();
        String username = userInfo.getMyusername().trim();
        String password = userInfo.getMypassword().trim();
        String repassword = userInfo.getRepassword().trim();
        String checkcode = userInfo.getCheckcode().trim();

        return  (username.length() != 0) && isSamePassword(password, repassword) && isValidEmailAddress(email) && isCorrectCheckCode(checkcode);
    }

    private boolean isSamePassword(String password, String repassword)
    {
        return (password.trim().equals(repassword));
    }

    private boolean isValidEmailAddress(String email)
    {
        if (email != null && email.length() != 0)
        {
            int index = email.lastIndexOf(".");
            int index1 = email.lastIndexOf("@");

            if (index > 0 && index1 > 0)
            {
                return email.substring(index + 1, email.length()).equals("com") && email.charAt(index - 1) != '@';
            }
        }

        return false;
    }

    private boolean isCorrectCheckCode(String checkcode)
    {
        if (checkcode != null && checkcode.length() != 0)
        {
            String code = (String) ServletActionContext.getRequest().getSession().getAttribute("checkcode");

            return code.equals(checkcode);
        }

        return false;
    }

}

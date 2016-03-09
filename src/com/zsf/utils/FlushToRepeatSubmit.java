package com.zsf.utils;

import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.dbUtils
 * @ 2015/10/20
 */
public class FlushToRepeatSubmit
{
    public static boolean checkToken()
    {
        String requestToken = ServletActionContext.getRequest().getParameter("requestToken");
        HttpSession session = ServletActionContext.getRequest().getSession();
        if (session.getAttribute("sessionToken") != null)
        {
            if (!session.getAttribute("sessionToken").toString().equals(requestToken))
            {
                return false;
            }
        }

            //生成新Token以防重复提交
            FlushToRepeatSubmit.addToken(session);
            return true;

    }

    public static void addToken(HttpSession session)
    {
        String token = FlushToRepeatSubmit.getToken(session);

        ServletActionContext.getRequest().getSession().setAttribute("requestToken", token);
        ServletActionContext.getRequest().getSession().setAttribute("sessionToken", token);
    }

    public static String getToken(HttpSession session)
    {
        return MD5.GetMD5Code(String.valueOf(session.getId()) + String.valueOf(System.currentTimeMillis()));
    }
}

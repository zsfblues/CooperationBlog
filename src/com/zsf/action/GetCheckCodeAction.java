package com.zsf.action;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class GetCheckCodeAction
{
    public void getCheckcode() throws Exception
    {
        try
        {
            String checkcode = makeRandomNumber();
            ServletActionContext.getRequest().getSession().setAttribute("checkcode", checkcode);
            ServletActionContext.getResponse().getWriter().println(checkcode);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    public String makeRandomNumber()
    {
        String num = new Random().nextInt(9999) + "";

        StringBuffer str = new StringBuffer();

        //生成的随机数小于四位就往前添加 0
        for (int i = 0; i < 4-num.length(); i++)
        {
            str.append("0");
        }

        num = str.toString() + num;

        return num;
    }
}
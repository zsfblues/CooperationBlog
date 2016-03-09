package com.zsf.dao;

import com.zsf.utils.FlushToRepeatSubmit;
import com.zsf.interfaces.Submit;
import com.zsf.javabean.BlogInfo;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.dao
 * @ 2015/10/19
 */
public class BlogSubmitImp implements Submit<BlogInfo>
{
    @Override
    public boolean isRepeatSubmit(String name)
    {
        HttpSession session = ServletActionContext.getRequest().getSession();
        String repeat_submit = (String) session.getAttribute(name);

        if (FlushToRepeatSubmit.checkToken())
        {
            //为空，则表示此前未提交
            if (repeat_submit == null)
            {
                session.setAttribute(name, session.getId());
                session.removeAttribute(name);

                return true;
            }
        }

        return false;
    }

    @Override
    public boolean checkInfoFormat(BlogInfo blogInfo)
    {
        String blogtitle = blogInfo.getBlogtitle();
        String blogtextarea = blogInfo.getBlogtextarea();
        String privilegeflag = blogInfo.getPrivilegeflag();

        return !(blogtitle == null || blogtextarea == null || privilegeflag == null) && (blogtitle.length() != 0) && (blogtextarea.length() != 0);
    }
}

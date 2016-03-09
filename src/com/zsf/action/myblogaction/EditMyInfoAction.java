package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletContext;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.myblogaction
 * @ 2015/11/6
 */
public class EditMyInfoAction extends ActionSupport
{
    @Override
    public String execute() throws Exception
    {
        ValueStack valueStack = ActionContext.getContext().getValueStack();

        List<String[]> list = QueryHelper.executeQuery("select username, signname from users where user_id = ?", ServletActionContext.getRequest().getSession().getAttribute("userId"));

        valueStack.set("infolist", list);
        return SUCCESS;
    }
}

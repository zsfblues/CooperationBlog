package com.zsf.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.zsf.dao.RegisterSubmitImp;
import com.zsf.dao.SubmitContext;
import com.zsf.dbUtils.InsertHelper;
import com.zsf.utils.MD5;
import com.zsf.javabean.UserInfo;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action
 * @ 2015/10/17
 */
public class RegisterAction extends ActionSupport implements ModelDriven<UserInfo>
{
    private UserInfo userInfo = new UserInfo();

    @Override
    public String execute() throws Exception
    {
        SubmitContext<UserInfo> submitContext = new SubmitContext<>(new RegisterSubmitImp(), userInfo);

        if (submitContext.ContextSubmit("register_repeat_submit"))
        {
            String md5Password = MD5.GetMD5Code(userInfo.getMypassword());

            InsertHelper.executeInsert("insert into users(user_id, email, username, password, regist_time) values(null, ?, ?, ?, now())", userInfo.getEmail(), userInfo.getMyusername(), md5Password);

        }

        return SUCCESS;
    }

    @Override
    public UserInfo getModel()
    {
        return userInfo;
    }
}

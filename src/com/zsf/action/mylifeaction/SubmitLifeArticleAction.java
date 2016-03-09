package com.zsf.action.mylifeaction;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.zsf.dbUtils.InsertHelper;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.javabean.LifeBlogInfo;
import com.zsf.utils.FlushToRepeatSubmit;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.mylifeaction
 * @ 2015/11/2
 */
public class SubmitLifeArticleAction extends ActionSupport implements ModelDriven<LifeBlogInfo>
{
    private LifeBlogInfo lifeBlogInfo = new LifeBlogInfo();

    @Override
    public String execute() throws Exception
    {
        HttpSession session = ServletActionContext.getRequest().getSession();

        if (FlushToRepeatSubmit.checkToken() && checkInfoFormat())
        {
            InsertHelper.executeInsert("insert into blogarticle values(null, now(), ?, ?, ?, ?, ?, 0, ?, 'L')", lifeBlogInfo.getMysharecontent(), session.getAttribute("userId"), lifeBlogInfo.getTitle(), lifeBlogInfo.getTag(), lifeBlogInfo.getPrivilegeflag(), lifeBlogInfo.getLead());

            //存放文章的临时图片资源以便以后用户放弃上传后删除
            List<String[]> list = QueryHelper.executeQuery("select max(article_id) from blogarticle where user_id = ?", session.getAttribute("userId"));

            //表明该用户并没用上传图片而只是单纯写篇生活类博文
            if (session.getAttribute((String)session.getAttribute("userId")) != null)
            {
                InsertHelper.executeInsert("insert into lifeimgres(dirname, article_id, create_time) values(?, ?, now())", session.getAttribute("myemail").toString() + session.getAttribute((String) session.getAttribute("userId")), list.get(0)[0]);
                session.removeAttribute((String) session.getAttribute("userId"));
                session.removeAttribute("tempflag");
            }
        }

        return SUCCESS;
    }

    @Override
    public LifeBlogInfo getModel()
    {
        return lifeBlogInfo;
    }

    public boolean checkInfoFormat()
    {
        if (lifeBlogInfo.getTitle() == null || lifeBlogInfo.getLead() == null || lifeBlogInfo.getMysharecontent() == null || lifeBlogInfo.getPrivilegeflag() == null)
        {
            return false;
        }

        if ("".equals(lifeBlogInfo.getTitle()) || "".equals(lifeBlogInfo.getLead()) || "".equals(lifeBlogInfo.getMysharecontent()) || "".equals(lifeBlogInfo.getPrivilegeflag()))
        {
            return false;
        }

        return true;
    }
}

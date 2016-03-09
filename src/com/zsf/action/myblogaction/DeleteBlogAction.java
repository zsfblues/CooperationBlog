package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.DeleteHelper;
import com.zsf.dbUtils.QueryHelper;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.myblogaction
 * @ 2015/10/29
 */
public class DeleteBlogAction extends ActionSupport
{
    private String articleId;

    public void setArticleId(String articleId)
    {
        this.articleId = articleId;
    }

    @Override
    public String execute() throws Exception
    {
        if (isNum())
        {
            List<String[]> lifeBlogList = QueryHelper.executeQuery("SELECT typeflag, dirname FROM blogarticle LEFT JOIN lifeimgres ON blogarticle.article_id = lifeimgres.article_id WHERE blogarticle.article_id = ?", this.articleId);
            if ("L".equals(lifeBlogList.get(0)[0]))
            {
                //如果是生活类博客就连带图片文件夹一起删除(如果有的话)
                File lifeimgdir = new File(ServletActionContext.getServletContext().getRealPath("/sharelifeimg/") + lifeBlogList.get(0)[1]);
                DeleteHelper.executeDelete("DELETE FROM lifeimgres WHERE article_id = ?", this.articleId);
                if (lifeimgdir.exists() && lifeimgdir.isDirectory())
                {
                    FileUtils.deleteDirectory(lifeimgdir);
                }
            }

            //删除博文后连带回复一起删除，因为删除对象从上至下不存在依赖关系，所以要逐个删除
            DeleteHelper.executeDelete("DELETE FROM blogarticle WHERE blogarticle.article_id = ?", this.articleId);
            DeleteHelper.executeDelete("DELETE FROM reply WHERE article_id = ?", this.articleId);
            DeleteHelper.executeDelete("DELETE FROM subreply WHERE article_id = ?", this.articleId);

            //判断博文是否存在图片资源
            List<String[]> list = QueryHelper.executeQuery("select dirname from lifeimgres where article_id = ?", this.articleId);
            if (list.size() != 0)
            {
                File file = new File(ServletActionContext.getServletContext().getRealPath("/sharelifeimg/") + list.get(0)[0]);

                if (file.exists() && file.isDirectory())
                {
                    FileUtils.deleteDirectory(file);
                }

                DeleteHelper.executeDelete("delete from lifeimgres where article_id = ?", this.articleId);
            }
        }

        return SUCCESS;
    }

    public boolean isNum()
    {
        for (int i = 0; i < this.articleId.length(); i++)
        {
            if (!Character.isDigit(this.articleId.charAt(i)))
            {
                return false;
            }
        }

        return true;
    }
}

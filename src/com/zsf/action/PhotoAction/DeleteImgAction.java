package com.zsf.action.PhotoAction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.DeleteHelper;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.utils.FlushToRepeatSubmit;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.PhotoAction
 * @ 2015/10/30
 */
public class DeleteImgAction extends ActionSupport
{
    private String imgId;

    public void setImgId(String imgId)
    {
        this.imgId = imgId;
    }

    @Override
    public String execute() throws Exception
    {

        if (this.imgId != null && FlushToRepeatSubmit.checkToken() && isNum())
        {
            //先删文件， 不然数据库删除后无法查找该文件
            List<String[]> imglist = QueryHelper.executeQuery("select newfilename from image where img_id = ?", Integer.parseInt(this.imgId));

            if (imglist.size() != 0)
            {
                File file = new File(ServletActionContext.getServletContext().getRealPath("/uploadimg/") + imglist.get(0)[0]);
                if (file.exists())
                {
                    file.delete();
                }
            }

            DeleteHelper.executeDelete("delete from image where img_id = ? and user_id = ?", this.imgId, ServletActionContext.getRequest().getSession().getAttribute("userId"));

        }

        List<String[]> list = QueryHelper.executeQuery("select users.username, img_id, image.user_id, filename, newfilename  from image, users WHERE users.user_id = image.user_id ORDER BY upload_time");

        ServletActionContext.getContext().getValueStack().set("imagelist", list);

        return SUCCESS;
    }

    public boolean isNum()
    {
        for (int i = 0; i < this.imgId.length(); i++)
        {
            if (!Character.isDigit(this.imgId.charAt(i)) || "".equals(this.imgId))
            {
                return false;
            }
        }

        return true;
    }
}

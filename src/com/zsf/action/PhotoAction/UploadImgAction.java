package com.zsf.action.PhotoAction;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.InsertHelper;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.javabean.Uploadinfo;
import com.zsf.utils.DeleteDir;
import com.zsf.utils.FlushToRepeatSubmit;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.*;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.PhotoAction
 * @ 2015/10/29
 */
public class UploadImgAction extends ActionSupport implements ModelDriven<Uploadinfo>
{
    private Uploadinfo uploadinfo = new Uploadinfo();

    @Override
    public String execute() throws Exception
    {
        DeleteDir.checkTempDir();

        ValueStack valueStack = ServletActionContext.getContext().getValueStack();
        if (FlushToRepeatSubmit.checkToken() && uploadinfo.getUploadimg() != null)
        {
            String newFileName = System.currentTimeMillis() + uploadinfo.getUploadimgFileName();
            String absolutePath = ServletActionContext.getServletContext().getRealPath("/uploadimg/" + newFileName);

            //将源文件复制到目标文件目录下
            File destFile = new File(absolutePath);
            FileUtils.copyFile(uploadinfo.getUploadimg(), destFile);

      //    copyUploadFile(absolutePath);

            InsertHelper.executeInsert("insert into image(img_id, user_id, upload_time, filename, newfilename) values(null, ?, now(), ?, ?)", ServletActionContext.getRequest().getSession().getAttribute("userId"), uploadinfo.getUploadimgFileName(), newFileName);

            valueStack.set("uploadflag", "1");
        }

        List<String[]> list = QueryHelper.executeQuery("select users.username, img_id, image.user_id, filename, newfilename  from image, users WHERE users.user_id = image.user_id ORDER BY upload_time");

        valueStack.set("imagelist", list);

        return SUCCESS;
    }

    @Override
    public Uploadinfo getModel()
    {
        return uploadinfo;
    }

/*    public void copyUploadFile(String absolutePath)
    {
        FileOutputStream fos = null;
        FileInputStream fis = null;

        try
        {
            fos = new FileOutputStream(new File(absolutePath));
            fis = new FileInputStream(this.uploadinfo.getUploadimg());

            byte[] buffer = new byte[1024];
            int len;

            while ((len = fis.read(buffer)) > 0)
            {
                fos.write(buffer, 0, len);
            }

        } catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            try
            {
                if (fis != null)
                    fis.close();

            } catch (IOException e)
            {
                e.printStackTrace();
            }

            try
            {
                if (fos != null)
                    fos.close();
            } catch (IOException e)
            {
                e.printStackTrace();
            }
        }
    }*/
}

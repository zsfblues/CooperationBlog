package com.zsf.utils;

import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import java.io.File;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.utils
 * @ 2015/11/3
 */
public class DeleteDir
{
    public static void deleteAllFiles(String dirPath)
    {
        File file = new File(dirPath);

        if ( (file.exists() && file.isFile()) || (file.exists() && file.list().length == 0))
        {
            file.delete();
        }
        else
        {
            File[] files = file.listFiles();

            if (files != null)
            {
                for(File f : files)
                {
                    DeleteDir.deleteAllFiles(f.getAbsolutePath());
                    f.delete();     //当将f目录(如果是的话)下所有文件删除后将目录删除
                }

                file.delete();       //删除根节点的目录
            }
        }
    }

    public static void checkTempDir()
    {
        HttpSession session = ServletActionContext.getRequest().getSession();

        if (session.getAttribute( (String)session.getAttribute("userId")) != null && session.getAttribute("tempflag") != null)
        {
            if (session.getAttribute("tempflag") != null && "true".equals(session.getAttribute("tempflag").toString()) )
            {
                DeleteDir.deleteAllFiles(ServletActionContext.getServletContext().getRealPath("/sharelifeimg/") + session.getAttribute("myemail") + session.getAttribute((String) session.getAttribute("userId")));
                session.removeAttribute((String) session.getAttribute("userId"));
            }
        }
    }
}

package com.zsf.action.dynamicnewsaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.utils.BranchPage;
import com.zsf.utils.DeleteDir;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.dynamicaction
 * @ 2015/10/21
 */
public class ShowLastestArticleAction extends ActionSupport
{
    private String pageIndex;
    private String startIndex;

    public void setStartIndex(String startIndex)
    {
        this.startIndex = startIndex;
    }

    public void setPageIndex(String pageIndex)
    {
        this.pageIndex = pageIndex;
    }

    @Override
    public String execute() throws Exception
    {
        DeleteDir.checkTempDir();

        ValueStack valueStack = ActionContext.getContext().getValueStack();
        HttpServletRequest request =  ServletActionContext.getRequest();

        this.pageIndex = (this.pageIndex == null || "".equals(this.pageIndex))? "1" : this.pageIndex;
        this.startIndex = (this.startIndex == null || "".equals(this.startIndex)? "1" : this.startIndex);

        toNumber();

        int sIndex = Integer.parseInt(startIndex);
        int pIndex = Integer.parseInt(pageIndex);
        List<String[]> articleCounts = QueryHelper.executeQuery("select count(*) from blogarticle where privilegeflag = 1");
        int totalPages = Integer.parseInt(articleCounts.get(0)[0]) / 7 + 1;

        List<String[]> list = QueryHelper.executeQuery("select typeflag, article_id, views, title, leadword, content, tag, pub_time, users.username from blogarticle, users where privilegeflag = 1 and users.user_id = blogarticle.user_id ORDER BY pub_time DESC LIMIT ?, 7", 7 * (pIndex - 1));

        valueStack.set("lastbloglist", list);

        BranchPage branchPage = new BranchPage(startIndex, pageIndex);
        totalPages = branchPage.showCorrectIndex(sIndex, pIndex, totalPages, Integer.parseInt(articleCounts.get(0)[0]));
        
        request.setAttribute("startIndex", branchPage.getStartIndex());
        request.setAttribute("totalpages", totalPages);

        return SUCCESS;
    }

    public void toNumber()
    {
        for (int i = 0; i < this.pageIndex.length(); i++)
        {
            if (!Character.isDigit(this.pageIndex.charAt(i)))
            {
                this.pageIndex = "1";
                break;
            }
        }

        for (int i = 0; i < this.startIndex.length(); i++)
        {
            if (!Character.isDigit(this.startIndex.charAt(i)))
            {
                this.startIndex = "1";
                break;
            }
        }
    }
}

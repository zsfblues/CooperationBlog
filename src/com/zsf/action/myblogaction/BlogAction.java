package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.javabean.BlogInfo;
import com.zsf.utils.BranchPage;
import com.zsf.utils.DeleteDir;
import com.zsf.utils.FlushToRepeatSubmit;
import org.apache.struts2.ServletActionContext;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.myblogaction
 * @ 2015/10/18
 */
public class BlogAction extends ActionSupport
{
    private String pageIndex;
    private String startIndex;

    public void setPageIndex(String pageIndex)
    {
        this.pageIndex = pageIndex;
    }

    public void setStartIndex(String startIndex)
    {
        this.startIndex = startIndex;
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

        String userId = (String) ServletActionContext.getRequest().getSession().getAttribute("userId");

        List<String[]> articleCounts = QueryHelper.executeQuery("select count(*) from blogarticle  where user_id = ?", userId);
        int totalPages = Integer.parseInt(articleCounts.get(0)[0]) / 7 + 1;

        List<String[]> list = QueryHelper.executeQuery("select typeflag, article_id, title, leadword, content, tag, pub_time from blogarticle where user_id = ? LIMIT ?, 7", Integer.parseInt(userId), 7 * (pIndex - 1));

        String popularity = QueryHelper.getPersonPopularity(Integer.parseInt(userId));

        valueStack.set("bloglist", list);
        valueStack.set("popularity", popularity);

        BranchPage branchPage = new BranchPage(startIndex, pageIndex);
        totalPages = branchPage.showCorrectIndex(sIndex, pIndex, totalPages, Integer.parseInt(articleCounts.get(0)[0]));

        request.setAttribute("startIndex", branchPage.getStartIndex());
        request.setAttribute("totalpages", totalPages);
        request.setAttribute("blogcount", articleCounts.get(0)[0]);

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

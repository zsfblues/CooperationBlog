package com.zsf.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.InsertHelper;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.javabean.Reply;
import com.zsf.utils.FlushToRepeatSubmit;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ 周盛帆
 * @ BlogReply
 * @ com.zsf.action
 * @ 2015/10/10
 */
public class ReplyAction extends ActionSupport
{
    private Reply reply;
    private String articleId;

    public void setArticleId(String articleId)
    {
        this.articleId = articleId;
    }

    public void setReply(Reply reply)
    {
        this.reply = reply;
    }

    @Override
    public String execute() throws Exception
    {
        String reply_content = reply.getReply_content();
        String subreply_content = reply.getSubreply_textarea();

        ValueStack valueStack = ActionContext.getContext().getValueStack();
        HttpSession session = ServletActionContext.getRequest().getSession();

        if (FlushToRepeatSubmit.checkToken())
        {
            if (reply_content != null)
            {
                if (!"".equals(reply_content.trim()))
                {
                    InsertHelper.executeInsert("insert into reply values(null, ?, now(), ?, ?)", this.articleId, reply.getReply_content(), session.getAttribute("userId"));

                }
            }
            if (subreply_content != null)
            {
                if (!"".equals(subreply_content.trim()))
                {
                    InsertHelper.executeInsert("insert into subreply values(null, ?, ?, now(), ?, ?, ?)", reply.getReplyId(), this.articleId, subreply_content, session.getAttribute("userId"), reply.getMyreceiver());
                }
            }
        }

        getReplylist(valueStack);

        return "blog_page";
    }

    public void getReplylist(ValueStack valueStack)
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String index = request.getParameter("page_index");

        int pageIndex = Integer.parseInt(index == null ? "1" : index);

        //取得总数据个数,以便判断上，下一页是否会超出范围
        List<String[]> replyCounts = QueryHelper.executeQuery("select count(*) from reply where article_id = ?", this.articleId);
        int total = Integer.parseInt(replyCounts.get(0)[0]);

        pageIndex = pageIndex >= (total/3 + 1)? (total/3 + 1) : (pageIndex <= 0? 1 : pageIndex);

        if (total == 3)
        {
            total = total/3;
        }
        //临界条件:当前数据个数正好排满页面
        if (3 * (pageIndex - 1) == total && total != 0)
        {
            pageIndex--;
            total = total/3;
        }
        else
        {
            total = total/3 + 1;
        }

        List<String[]> replyList = QueryHelper.executeQuery("select username, pub_time, reply_id, reply.user_id, content from reply, users where article_id = ? AND reply.user_id = users.user_id ORDER BY pub_time DESC limit ?, ?", this.articleId, 3 * (pageIndex - 1) , 3);

        List<String[]> subreplyList = QueryHelper.getSubreply(this.articleId);
        valueStack.set("replylist", replyList);
        valueStack.set("subreplylist", subreplyList);

        valueStack.set("page_index", pageIndex);
        valueStack.set("pagecounts", total);
    }
}

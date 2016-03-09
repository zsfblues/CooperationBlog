package com.zsf.javabean;

/**
 * @ 周盛帆
 * @ BlogReply
 * @ com.zsf.javabean
 * @ 2015/10/10
 */
public class Reply
{
    private String reply_content;
    private String subreply_textarea;
    private String replyId;
    private String myreceiver;

    public String getMyreceiver()
    {
        return myreceiver;
    }

    public void setMyreceiver(String myreceiver)
    {
        this.myreceiver = myreceiver;
    }

    public String getReplyId()
    {
        return replyId;
    }

    public void setReplyId(String replyId)
    {
        this.replyId = replyId;
    }

    public String getSubreply_textarea()
    {
        return subreply_textarea;
    }

    public void setSubreply_textarea(String subreply_textarea)
    {
        this.subreply_textarea = subreply_textarea;
    }

    public String getReply_content()
    {
        return reply_content;
    }

    public void setReply_content(String reply_content)
    {
        this.reply_content = reply_content;
    }
}

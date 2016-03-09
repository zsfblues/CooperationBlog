package com.zsf.javabean;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.javabean
 * @ 2015/10/17
 */
public class UserInfo
{
    private String email;
    private String myusername;
    private String mypassword;
    private String repassword;
    private String checkcode;

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getMyusername()
    {
        return myusername;
    }

    public void setMyusername(String myusername)
    {
        this.myusername = myusername;
    }

    public String getMypassword()
    {
        return mypassword;
    }

    public void setMypassword(String mypassword)
    {
        this.mypassword = mypassword;
    }

    public String getRepassword()
    {
        return repassword;
    }

    public String getCheckcode()
    {
        return checkcode;
    }

    public void setCheckcode(String checkcode)
    {
        this.checkcode = checkcode;
    }

    public void setRepassword(String repassword)
    {
        this.repassword = repassword;

    }
}

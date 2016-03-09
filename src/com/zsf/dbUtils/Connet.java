package com.zsf.dbUtils;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * @ 周盛帆
 * @ BlogReply
 * @ com.zsf.dbUtils
 * @ 2015/10/10
 */
public class Connet
{
    private static final String url = "jdbc:mysql://localhost:3306/myblog";
    private static final String user = "root";
    private static final String password = "123";

    public static Connection getConnection()
    {
        Connection dbConnection = null;

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            dbConnection = DriverManager.getConnection(url, user, password);

        } catch (Exception e)
        {
            e.printStackTrace();
        }

        return dbConnection;
    }

}

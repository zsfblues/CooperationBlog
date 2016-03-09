package com.zsf.dbUtils;

import java.sql.*;

/**
 * @ 周盛帆
 * @ BlogReply
 * @ com.zsf.dbUtils
 * @ 2015/10/10
 */
public class InsertHelper
{
    public static void executeInsert(String sql, Object... parameters)
    {
        Connection con = Connet.getConnection();
        PreparedStatement ps = null;

        try
        {
            ps = con.prepareStatement(sql);

            for (int i = 1; i <= parameters.length; i++)
            {
                ps.setObject(i, parameters[i - 1]);
            }
            ps.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            InsertHelper.closeConnection(ps, con);
        }
    }

    public static void closeConnection(PreparedStatement ps, Connection con)
    {
        try
        {
            if (ps != null)
            {
                ps.close();
            }
        }
        catch (SQLException e)
        {
            throw new RuntimeException("数据关闭异常...");
        }

        try
        {
            if (con != null)
            {
                con.close();
            }
        }
        catch (SQLException e)
        {
            throw new RuntimeException("数据关闭异常...");
        }
    }
}

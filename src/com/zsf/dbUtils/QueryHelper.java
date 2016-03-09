package com.zsf.dbUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * @ 周盛帆
 * @ BlogReply
 * @ com.zsf.dbUtils
 * @ 2015/10/10
 */
public class QueryHelper
{
    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;

    public static List<String[]> executeQuery(String sql, Object... parameters)
    {
        con = Connet.getConnection();
        List<String[]> list = new ArrayList<>();

        try
        {
            ps = con.prepareStatement(sql);

            for (int i = 1; i <= parameters.length; i++)
            {
                ps.setObject(i, parameters[i - 1]);
            }

            rs = ps.executeQuery();
            int column = rs.getMetaData().getColumnCount();

            while (rs.next())
            {
                String[] objects = new String[column];

                for (int i = 1; i <= column; i++)
                {
                    objects[i - 1] = rs.getString(i);
                }

                list.add(objects);
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            QueryHelper.closeConnection(ps, rs, con);
        }

        return list;
    }

    public static String getPersonPopularity(int userId)
    {
        con = Connet.getConnection();
        String popularity = "";

        try
        {
            ps = con.prepareStatement("SELECT popularity FROM users WHERE user_id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next())
            {
                 popularity = rs.getString(1);
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            QueryHelper.closeConnection(ps, rs, con);
        }

        return popularity;
    }

    public static List<String[]> getSubreply(String articleId)
    {
        ResultSet temprs = null;
        con = Connet.getConnection();

        List<String[]> list = new ArrayList<>();
        try
        {
            ps = con.prepareStatement("select subreply.subreply_id, subreply.reply_id, sender_id, subreply.pub_time, username from subreply INNER JOIN users ON sender_id = user_id where article_id = ? GROUP BY (sender_id + receiver_id), pub_time");

            ps.setInt(1, Integer.parseInt(articleId));
            rs = ps.executeQuery();
            int column = rs.getMetaData().getColumnCount();

            ps = con.prepareStatement("select username, subreply.content from subreply INNER JOIN users ON receiver_id = user_id where article_id = ? GROUP BY (sender_id + receiver_id), pub_time");
            ps.setInt(1, Integer.parseInt(articleId));
            temprs = ps.executeQuery();

            while (rs.next() && temprs.next())
            {
                StringBuilder stringBuilder = new StringBuilder();
                String[] objects = new String[column];

                //获取列数据
                for (int i = 1; i <= column; i++)
                {
                    switch (i)
                    {
                        case 1:
                        case 2:
                        case 3:
                        {
                            objects[i - 1] = rs.getString(i);
                            break;
                        }
                        case 4:
                        {
                            //获取发表时间
                            stringBuilder.append(rs.getString(i).substring(0, rs.getString(i).length() - 2)).append("&nbsp;&nbsp;&nbsp;&nbsp;");
                            break;
                        }
                        case 5:
                        {
                            //获取回复人与被回复者
                            stringBuilder.append(rs.getString(i)).append("&nbsp;&nbsp;&nbsp;&nbsp;回复&nbsp;&nbsp;&nbsp;&nbsp;").append(temprs.getString(1));

                            objects[i - 2] = stringBuilder.toString();  //将时间，回复人与被回复人合并
                            objects[i - 1] =  temprs.getString(2);      //将回复内容保存
                            break;
                        }
                    }
                }

                list.add(objects);
            }

            try
            {
                if (temprs != null)
                {
                    temprs.close();
                }
            }
            catch(SQLException e)
            {
                throw new RuntimeException("数据关闭异常...");
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        finally
        {
            QueryHelper.closeConnection(ps, rs, con);
        }

        return list;
    }

    public static void closeConnection(PreparedStatement ps, ResultSet rs, Connection con)
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
            if (rs != null)
            {
                rs.close();
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

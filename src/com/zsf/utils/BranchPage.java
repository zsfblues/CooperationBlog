package com.zsf.utils;

import com.opensymphony.xwork2.ActionSupport;

public class BranchPage extends ActionSupport
{
    private String startIndex;
    private String pageIndex;

    public BranchPage(String startIndex, String pageIndex)
    {
        this.startIndex = startIndex;
        this.pageIndex = pageIndex;
    }

    public String getStartIndex()
    {
        return startIndex;
    }

    public String getPageIndex()
    {
        return pageIndex;
    }

    public int showCorrectIndex(int sIndex, int pIndex, int totalPages, int articleCounts)
    {
        //如果点击的页码是最后一个
        if ( pIndex - sIndex == 4)
        {
            startIndex = pageIndex;

            if (pIndex + 4 < totalPages)
            {
                totalPages = 4 + pIndex;
            }
        }
        //点击的页码是第一个
        else if (pIndex == sIndex && pIndex != 1)
        {
            if (sIndex - 4 > 0)
            {
                totalPages = sIndex;
                startIndex = String.valueOf(sIndex - 4);
            }
        }
        else
        {
            totalPages = sIndex + 4;

            if (totalPages * 7 > articleCounts)
            {
                totalPages = articleCounts / 7 + 1;
            }
        }

        if ( (totalPages - 1) * 7 == articleCounts)
        {
            totalPages--;
        }

        return totalPages;
    }
}

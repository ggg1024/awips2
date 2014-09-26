// filename: VTECsignifTable.java
// author  : DBGEN
// created : Tue May 31 17:52:30 CDT 2011 using database hd_ob83oax
// description: This class is used to get data from and put data into the
//              vtecsignif table of an IHFS database
//
package ohd.hseb.ihfsdb.generated;

import java.sql.*;

import java.util.*;

import ohd.hseb.db.*;

public class VTECsignifTable extends DbTable
{
//-----------------------------------------------------------------
//  Private data
//-----------------------------------------------------------------
    private int _recordsFound = -1;
//-----------------------------------------------------------------
//  VTECsignifTable() - constructor to set statement variable and initialize
//		number of records found to zero
//-----------------------------------------------------------------
    public VTECsignifTable(Database database) 
    {
        //Constructor calls DbTable's constructor
        super(database);
        setTableName("vtecsignif");
    }


    //-----------------------------------------------------------------
    //  select() - this method is called with a where clause and returns
    //		a List of VTECsignifRecord objects
    //-----------------------------------------------------------------
    public List select(String where) throws SQLException
    {
        VTECsignifRecord record = null;

        // create a List to hold VTECsignif Records
        List recordList = new ArrayList();

        // set number of records found to zero
        _recordsFound = 0;

        // Create the SQL statement and issue it
        // construct the select statment
        String selectStatement = "SELECT * FROM vtecsignif " + where;

        // get the result set back from the query to the database
        ResultSet rs = getStatement().executeQuery(selectStatement);

        // loop through the result set
        while (rs.next())
        {
            // create an instance of a VTECsignifRecord
            // and store its address in oneRecord
            record = new VTECsignifRecord();

            // increment the number of records found
            _recordsFound++;

            // assign the data returned to the result set for one
            // record in the database to a VTECsignifRecord object

            record.setSignif(getString(rs, 1));
            record.setName(getString(rs, 2));
            
            // add this VTECsignifRecord object to the list
            recordList.add(record);
        }
        // Close the result set
        rs.close();

        // return a List which holds the VTECsignifRecord objects
        return recordList;

    } // end of select method

    //-----------------------------------------------------------------
    //  selectNRecords() - this method is called with a where clause and returns
    //		a List filled with a maximum of maxRecordCount of VTECsignifRecord objects 
    //-----------------------------------------------------------------
    public List selectNRecords(String where, int maxRecordCount) throws SQLException
    {
        VTECsignifRecord record = null;

        // create a List to hold VTECsignif Records
        List recordList = new ArrayList();

        // set number of records found to zero
        _recordsFound = 0;

        // Create the SQL statement and issue it
        // construct the select statment
        String selectStatement = "SELECT * FROM vtecsignif " + where;

        // get the result set back from the query to the database
        ResultSet rs = getStatement().executeQuery(selectStatement);

        // loop through the result set
        while (rs.next())
        {
            // create an instance of a VTECsignifRecord
            // and store its address in oneRecord
            record = new VTECsignifRecord();

            // increment the number of records found
            _recordsFound++;

            // assign the data returned to the result set for one
            // record in the database to a VTECsignifRecord object

            record.setSignif(getString(rs, 1));
            record.setName(getString(rs, 2));
            
            // add this VTECsignifRecord object to the list
            recordList.add(record);
            if (_recordsFound >= maxRecordCount)
            {
                break;
            }
        }
        // Close the result set
        rs.close();

        // return a List which holds the VTECsignifRecord objects
        return recordList;

    } // end of selectNRecords method

//-----------------------------------------------------------------
//  insert() - this method is called with a VTECsignifRecord object and..
//-----------------------------------------------------------------
    public int insert(VTECsignifRecord record)  throws SQLException
    {
        int returnCode=-999;

        // Create a SQL insert statement and issue it
        // construct the insert statement
        PreparedStatement insertStatement = getConnection().prepareStatement(
" INSERT INTO vtecsignif VALUES (?, ?        )");

        setString(insertStatement, 1, record.getSignif());
        setString(insertStatement, 2, record.getName());
        
        // get the number of records processed by the insert
        returnCode = insertStatement.executeUpdate();

        return returnCode;

    } // end of insert method

//-----------------------------------------------------------------
//  delete() - this method is called with a where clause and returns
//                   the number of records deleted
//-----------------------------------------------------------------
    public int delete(String where) throws SQLException
    {
        int returnCode=-999;

        // Create a SQL delete statement and issue it
        // construct the delete statement
        String deleteStatement = "DELETE FROM vtecsignif " + where;

        // get the number of records processed by the delete
        returnCode = getStatement().executeUpdate(deleteStatement);

        return returnCode;
    } // end of delete method 

//-----------------------------------------------------------------
//  update() - this method is called with a VTECsignifRecord object and a where clause..
//-----------------------------------------------------------------
    public int update(VTECsignifRecord record, String where)  throws SQLException
    {
        int returnCode=-999;
        // Create a SQL update statement and issue it
        // construct the update statement
        PreparedStatement updateStatement = getConnection().prepareStatement(
" UPDATE vtecsignif SET signif = ?, name = ?        " + where );

        setString(updateStatement, 1, record.getSignif());
        setString(updateStatement, 2, record.getName());
        // get the number of records processed by the update
        returnCode = updateStatement.executeUpdate();

        return returnCode;

    } // end of updateRecord method

//-----------------------------------------------------------------
//  delete() - this method is called with a where clause and returns
//                   the number of records deleted
//-----------------------------------------------------------------
    public int delete(VTECsignifRecord record) throws SQLException
    {
        int returnCode=-999;

        // Create a SQL delete statement and issue it
        // construct the delete statement
        String deleteStatement = "DELETE FROM vtecsignif " + record.getWhereString();

        // get the number of records processed by the delete
        returnCode = getStatement().executeUpdate(deleteStatement);

        return returnCode;
    } // end of delete method 

//-----------------------------------------------------------------
//  update() - this method is called with a VTECsignifRecord object and a where clause..
//-----------------------------------------------------------------
    public int update(VTECsignifRecord oldRecord, VTECsignifRecord newRecord)  throws SQLException
    {
        int returnCode=-999;
        // Create a SQL update statement and issue it
        // construct the update statement
        PreparedStatement updateStatement = getConnection().prepareStatement(
" UPDATE vtecsignif SET signif = ?, name = ?        " + oldRecord.getWhereString() );

        setString(updateStatement, 1, newRecord.getSignif());
        setString(updateStatement, 2, newRecord.getName());
        // get the number of records processed by the update
        returnCode = updateStatement.executeUpdate();

        return returnCode;

    } // end of updateRecord method

//-----------------------------------------------------------------
//  insertOrUpdate() - this method is call with a VTECsignifRecord object.
//                   the number of records inserted or updated
//-----------------------------------------------------------------
    public int insertOrUpdate(VTECsignifRecord record) throws SQLException
    {
        int returnCode=-999;
        List recordList = select(record.getWhereString());

        if (recordList.size() < 1)
        {
            returnCode = insert(record);
        }
        else
        {
            VTECsignifRecord oldRecord = (VTECsignifRecord) recordList.get(0);
            returnCode = update(oldRecord, record);
        }
        return returnCode;
    } // end of insertOrUpdate() 
} // end of VTECsignifTable class
// filename: CountyTransmitTable.java
// author  : DBGEN
// created : Tue May 31 17:52:20 CDT 2011 using database hd_ob83oax
// description: This class is used to get data from and put data into the
//              countytransmit table of an IHFS database
//
package ohd.hseb.ihfsdb.generated;

import java.sql.*;

import java.util.*;

import ohd.hseb.db.*;

public class CountyTransmitTable extends DbTable
{
//-----------------------------------------------------------------
//  Private data
//-----------------------------------------------------------------
    private int _recordsFound = -1;
//-----------------------------------------------------------------
//  CountyTransmitTable() - constructor to set statement variable and initialize
//		number of records found to zero
//-----------------------------------------------------------------
    public CountyTransmitTable(Database database) 
    {
        //Constructor calls DbTable's constructor
        super(database);
        setTableName("countytransmit");
    }


    //-----------------------------------------------------------------
    //  select() - this method is called with a where clause and returns
    //		a List of CountyTransmitRecord objects
    //-----------------------------------------------------------------
    public List select(String where) throws SQLException
    {
        CountyTransmitRecord record = null;

        // create a List to hold CountyTransmit Records
        List recordList = new ArrayList();

        // set number of records found to zero
        _recordsFound = 0;

        // Create the SQL statement and issue it
        // construct the select statment
        String selectStatement = "SELECT * FROM countytransmit " + where;

        // get the result set back from the query to the database
        ResultSet rs = getStatement().executeQuery(selectStatement);

        // loop through the result set
        while (rs.next())
        {
            // create an instance of a CountyTransmitRecord
            // and store its address in oneRecord
            record = new CountyTransmitRecord();

            // increment the number of records found
            _recordsFound++;

            // assign the data returned to the result set for one
            // record in the database to a CountyTransmitRecord object

            record.setCall_sign(getString(rs, 1));
            record.setCounty(getString(rs, 2));
            record.setState(getString(rs, 3));
            
            // add this CountyTransmitRecord object to the list
            recordList.add(record);
        }
        // Close the result set
        rs.close();

        // return a List which holds the CountyTransmitRecord objects
        return recordList;

    } // end of select method

    //-----------------------------------------------------------------
    //  selectNRecords() - this method is called with a where clause and returns
    //		a List filled with a maximum of maxRecordCount of CountyTransmitRecord objects 
    //-----------------------------------------------------------------
    public List selectNRecords(String where, int maxRecordCount) throws SQLException
    {
        CountyTransmitRecord record = null;

        // create a List to hold CountyTransmit Records
        List recordList = new ArrayList();

        // set number of records found to zero
        _recordsFound = 0;

        // Create the SQL statement and issue it
        // construct the select statment
        String selectStatement = "SELECT * FROM countytransmit " + where;

        // get the result set back from the query to the database
        ResultSet rs = getStatement().executeQuery(selectStatement);

        // loop through the result set
        while (rs.next())
        {
            // create an instance of a CountyTransmitRecord
            // and store its address in oneRecord
            record = new CountyTransmitRecord();

            // increment the number of records found
            _recordsFound++;

            // assign the data returned to the result set for one
            // record in the database to a CountyTransmitRecord object

            record.setCall_sign(getString(rs, 1));
            record.setCounty(getString(rs, 2));
            record.setState(getString(rs, 3));
            
            // add this CountyTransmitRecord object to the list
            recordList.add(record);
            if (_recordsFound >= maxRecordCount)
            {
                break;
            }
        }
        // Close the result set
        rs.close();

        // return a List which holds the CountyTransmitRecord objects
        return recordList;

    } // end of selectNRecords method

//-----------------------------------------------------------------
//  insert() - this method is called with a CountyTransmitRecord object and..
//-----------------------------------------------------------------
    public int insert(CountyTransmitRecord record)  throws SQLException
    {
        int returnCode=-999;

        // Create a SQL insert statement and issue it
        // construct the insert statement
        PreparedStatement insertStatement = getConnection().prepareStatement(
" INSERT INTO countytransmit VALUES (?, ?, ?        )");

        setString(insertStatement, 1, record.getCall_sign());
        setString(insertStatement, 2, record.getCounty());
        setString(insertStatement, 3, record.getState());
        
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
        String deleteStatement = "DELETE FROM countytransmit " + where;

        // get the number of records processed by the delete
        returnCode = getStatement().executeUpdate(deleteStatement);

        return returnCode;
    } // end of delete method 

//-----------------------------------------------------------------
//  update() - this method is called with a CountyTransmitRecord object and a where clause..
//-----------------------------------------------------------------
    public int update(CountyTransmitRecord record, String where)  throws SQLException
    {
        int returnCode=-999;
        // Create a SQL update statement and issue it
        // construct the update statement
        PreparedStatement updateStatement = getConnection().prepareStatement(
" UPDATE countytransmit SET call_sign = ?, county = ?, state = ?        " + where );

        setString(updateStatement, 1, record.getCall_sign());
        setString(updateStatement, 2, record.getCounty());
        setString(updateStatement, 3, record.getState());
        // get the number of records processed by the update
        returnCode = updateStatement.executeUpdate();

        return returnCode;

    } // end of updateRecord method

//-----------------------------------------------------------------
//  delete() - this method is called with a where clause and returns
//                   the number of records deleted
//-----------------------------------------------------------------
    public int delete(CountyTransmitRecord record) throws SQLException
    {
        int returnCode=-999;

        // Create a SQL delete statement and issue it
        // construct the delete statement
        String deleteStatement = "DELETE FROM countytransmit " + record.getWhereString();

        // get the number of records processed by the delete
        returnCode = getStatement().executeUpdate(deleteStatement);

        return returnCode;
    } // end of delete method 

//-----------------------------------------------------------------
//  update() - this method is called with a CountyTransmitRecord object and a where clause..
//-----------------------------------------------------------------
    public int update(CountyTransmitRecord oldRecord, CountyTransmitRecord newRecord)  throws SQLException
    {
        int returnCode=-999;
        // Create a SQL update statement and issue it
        // construct the update statement
        PreparedStatement updateStatement = getConnection().prepareStatement(
" UPDATE countytransmit SET call_sign = ?, county = ?, state = ?        " + oldRecord.getWhereString() );

        setString(updateStatement, 1, newRecord.getCall_sign());
        setString(updateStatement, 2, newRecord.getCounty());
        setString(updateStatement, 3, newRecord.getState());
        // get the number of records processed by the update
        returnCode = updateStatement.executeUpdate();

        return returnCode;

    } // end of updateRecord method

//-----------------------------------------------------------------
//  insertOrUpdate() - this method is call with a CountyTransmitRecord object.
//                   the number of records inserted or updated
//-----------------------------------------------------------------
    public int insertOrUpdate(CountyTransmitRecord record) throws SQLException
    {
        int returnCode=-999;
        List recordList = select(record.getWhereString());

        if (recordList.size() < 1)
        {
            returnCode = insert(record);
        }
        else
        {
            CountyTransmitRecord oldRecord = (CountyTransmitRecord) recordList.get(0);
            returnCode = update(oldRecord, record);
        }
        return returnCode;
    } // end of insertOrUpdate() 
} // end of CountyTransmitTable class

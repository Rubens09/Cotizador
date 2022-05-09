using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Reflection;
using Utility.Widget.eraLogger;

namespace Utility.Widget.eraDBConnect
{
    public enum TypeDB
    {
        SQLServer = 1,
        Access = 2,
        Firebird = 3,
        MySQL = 4
    }

    public class Parameter
    {
        public string Name;
        public object Value;

        public Parameter(string name, object value)
        {
            this.Name = name;
            this.Value = value;
        }
    }

    public class DBConnect : IDisposable
    {
        #region Variables

        private static volatile DBConnect _Instance;
        private bool IsFailConn = false;
        public TypeDB TypeDB;
        public string ConnString;
        public string QueryString;
        public List<Parameter> Parameters = null;

        #endregion

        #region Properties

        public static DBConnect Instance
        {
            get
            {
                if (_Instance == null)
                    _Instance = new DBConnect();

                return _Instance;
            }
        }

        public bool IsFailConnection
        {
            get
            {
                return IsFailConn;
            }
        }

        #endregion

        #region Methods

        public int ExecuteNonQuery()
        {
            int Result = 0;

            try
            {
                switch (this.TypeDB)
                {
                    case TypeDB.SQLServer:
                        Result = (int)SqlConn(ConnString, QueryString, Parameters, false);
                        break;
                    case TypeDB.Access:
                        Result = (int)OleDbConn(ConnString, QueryString, Parameters, false);
                        break;
                    case TypeDB.Firebird:
                        Result = (int)FbConn2(ConnString, QueryString, Parameters, false);
                        break;
                    case TypeDB.MySQL:
                        Result = (int)MySqlConn(ConnString, QueryString, Parameters, false);
                        break;
                }
            }
            catch(Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBConnect.E.001", ex, true);
            }

            return Result;
        }

        public int ExecuteNonQuery(TypeDB TypeDB, string ConnString, string QueryString)
        {
            this.TypeDB = TypeDB;
            this.ConnString = ConnString;
            this.QueryString = QueryString;

            return ExecuteNonQuery();
        }

        public int ExecuteNonQuery(TypeDB TypeDB, string ConnString, string QueryString, Parameter Parameter)
        {
            List<Parameter> Parameters = new List<Parameter>();
            Parameters.Add(Parameter);

            this.TypeDB = TypeDB;
            this.ConnString = ConnString;
            this.QueryString = QueryString;
            this.Parameters = Parameters;

            return ExecuteNonQuery();
        }

        public int ExecuteNonQuery(TypeDB TypeDB, string ConnString, string QueryString, List<Parameter> Parameters)
        {
            this.TypeDB = TypeDB;
            this.ConnString = ConnString;
            this.QueryString = QueryString;
            this.Parameters = Parameters;

            return ExecuteNonQuery();
        }

        public DataTable ExecuteQuery()
        {
            DataTable Result = null;
            try
            {
                switch (this.TypeDB)
                {
                    case TypeDB.SQLServer:
                        Result = (DataTable)SqlConn(ConnString, QueryString, Parameters, true);
                        break;
                    case TypeDB.Access:
                        Result = (DataTable)OleDbConn(ConnString, QueryString, Parameters, true);
                        break;
                    case TypeDB.Firebird:
                        Result = (DataTable)FbConn2(ConnString, QueryString, Parameters, true);
                        break;
                    case TypeDB.MySQL:
                        Result = (DataTable)MySqlConn(ConnString, QueryString, Parameters, true);
                        break;
                }
            }
            catch(Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBConnect.E.002", ex);
            }

            return Result;
        }

        public DataTable ExecuteQuery(TypeDB TypeDB, string ConnString, string QueryString)
        {
            this.TypeDB = TypeDB;
            this.ConnString = ConnString;
            this.QueryString = QueryString;

            return ExecuteQuery();
        }

        public DataTable ExecuteQuery(TypeDB TypeDB, string ConnString, string QueryString, Parameter Parameter)
        {
            List<Parameter> Parameters = new List<Parameter>();
            Parameters.Add(Parameter);

            this.TypeDB = TypeDB;
            this.ConnString = ConnString;
            this.QueryString = QueryString;
            this.Parameters = Parameters;

            return ExecuteQuery();
        }

        public DataTable ExecuteQuery(TypeDB TypeDB, string ConnString, string QueryString, List<Parameter> Parameters)
        {
            this.TypeDB = TypeDB;
            this.ConnString = ConnString;
            this.QueryString = QueryString;
            this.Parameters = Parameters;

            return ExecuteQuery();
        }

        private object OleDbConn(string ConnString, string QueryString, List<Parameter> Parameters, bool IsReturnable)
        {
            object Result = null;

            try
            {
                using (OleDbConnection connection = new OleDbConnection(ConnString))
                {
                    OleDbCommand oleDbCommand = new OleDbCommand(QueryString, connection);

                    try
                    {
                        connection.Open();

                        if (Parameters != null)
                        {
                            foreach (Parameter Param in Parameters)
                            {
                                object ValueParameter = Param.Value;

                                if (ValueParameter == null)
                                    ValueParameter = DBNull.Value;

                                oleDbCommand.Parameters.AddWithValue(Param.Name, ValueParameter);
                            }
                        }

                        if (IsReturnable)
                        {
                            using (OleDbDataAdapter oleDbAdapter = new OleDbDataAdapter(oleDbCommand))
                            {
                                DataTable dataTable = new DataTable();
                                oleDbAdapter.Fill(dataTable);
                                Result = (object)dataTable;
                            }
                        }
                        else
                        {
                            Result = oleDbCommand.ExecuteNonQuery();
                        }
                    }
                    catch (DbException)
                    {
                        IsFailConn = true;
                    }
                    finally
                    {
                        oleDbCommand.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBConnect.E.003", ex);
            }

            return Result;
        }

        private object SqlConn(string ConnString, string QueryString, List<Parameter> Parameters, bool IsReturnable)
        {
            object Result = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(ConnString))
                {
                    SqlCommand sqlCommand = new SqlCommand(QueryString, connection);

                    try
                    {
                        connection.Open();

                        if (Parameters != null)
                        {
                            foreach (Parameter Param in Parameters)
                            {
                                object ValueParameter = Param.Value;

                                if (ValueParameter == DBNull.Value || ValueParameter == null)
                                    ValueParameter = DBNull.Value;

                                sqlCommand.Parameters.AddWithValue(Param.Name, ValueParameter);
                            }
                        }

                        if (IsReturnable)
                        {
                            using (SqlDataAdapter SqlAdapter = new SqlDataAdapter(sqlCommand))
                            {
                                DataTable dataTable = new DataTable();
                                SqlAdapter.Fill(dataTable);
                                Result = (object)dataTable;
                            }
                        }
                        else
                        {
                            Result = sqlCommand.ExecuteNonQuery();
                        }
                    }
                    catch (DbException)
                    {
                        IsFailConn = true;
                    }
                    finally
                    {
                        sqlCommand.Dispose();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBConect.E.004", ex);
            }

            return Result;
        }

        private object FbConn2(string ConnString, string QueryString, List<Parameter> Parameters, bool IsReturnable)
        {
            object Result = null;

            try
            {
                string PathDLL = "FirebirdSql.Data.FirebirdClient.dll";

                if (File.Exists(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "lib", PathDLL)))
                {
                    Assembly FirebirdSqlAssembly = Assembly.LoadFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "lib", PathDLL));
                    Type FbConnectionType = FirebirdSqlAssembly.GetType("FirebirdSql.Data.FirebirdClient.FbConnection");
                    Type FbCommandType = FirebirdSqlAssembly.GetType("FirebirdSql.Data.FirebirdClient.FbCommand");
                    Type FbDataAdapterType = FirebirdSqlAssembly.GetType("FirebirdSql.Data.FirebirdClient.FbDataAdapter");

                    using (dynamic connection = Activator.CreateInstance(FbConnectionType))
                    {
                        connection.ConnectionString = ConnString;
                        dynamic fbCommand = Activator.CreateInstance(FbCommandType);
                        fbCommand.CommandText = QueryString;
                        fbCommand.Connection = connection;

                        try
                        {
                            connection.Open();

                            if (Parameters != null)
                            {
                                foreach (Parameter Param in Parameters)
                                {
                                    object ValueParameter = Param.Value;

                                    if (ValueParameter == DBNull.Value || ValueParameter == null)
                                        ValueParameter = DBNull.Value;

                                    fbCommand.Parameters.AddWithValue(Param.Name, ValueParameter);
                                }
                            }

                            if (IsReturnable)
                            {
                                using (dynamic SqlAdapter = Activator.CreateInstance(FbDataAdapterType))
                                {
                                    SqlAdapter.SelectCommand = fbCommand;
                                    DataTable dataTable = new DataTable();
                                    SqlAdapter.Fill(dataTable);
                                    Result = (object)dataTable;
                                }
                            }
                            else
                            {
                                Result = fbCommand.ExecuteNonQuery();
                            }
                        }
                        catch (Exception ex)
                        {
                            IsFailConn = true;
                        }
                        finally
                        {
                            fbCommand.Dispose();
                        }
                    }
                }
                else
                {
                    throw new Exception("No se encuentra la librería " + PathDLL);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBConect.E.005", ex);
            }

            return Result;
        }

        private object MySqlConn(string ConnString, string QueryString, List<Parameter> Parameters, bool IsReturnable)
        {
            object Result = null;

            try
            {
                string PathDLL = "MySql.Data.dll";

                if (File.Exists(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "lib", PathDLL)))
                {
                    Assembly MySqlAssembly = Assembly.LoadFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "lib", PathDLL));
                    Type MySqlConnectioType = MySqlAssembly.GetType("MySql.Data.MySqlClient.MySqlConnection");
                    Type MySqlCommandType = MySqlAssembly.GetType("MySql.Data.MySqlClient.MySqlCommand");
                    Type MySqlDataAdapterType = MySqlAssembly.GetType("MySql.Data.MySqlClient.MySqlDataAdapter");
                    Type MySqlExceptionType = MySqlAssembly.GetType("MySql.Data.MySqlClient.MySqlException");

                    using (dynamic connection = Activator.CreateInstance(MySqlConnectioType))
                    {
                        connection.ConnectionString = ConnString;
                        dynamic MySqlCommand = Activator.CreateInstance(MySqlCommandType);
                        MySqlCommand.CommandText = QueryString;
                        MySqlCommand.Connection = connection;

                        try
                        {
                            connection.Open();

                            if (Parameters != null)
                            {
                                foreach (Parameter Param in Parameters)
                                {
                                    object ValueParameter = Param.Value;

                                    if (ValueParameter == DBNull.Value || ValueParameter == null)
                                        ValueParameter = DBNull.Value;

                                    MySqlCommand.Parameters.AddWithValue(Param.Name, ValueParameter);
                                }
                            }

                            if (IsReturnable)
                            {
                                using (dynamic MySqlAdapter = Activator.CreateInstance(MySqlDataAdapterType))
                                {
                                    MySqlAdapter.SelectCommand = MySqlCommand;
                                    DataTable dataTable = new DataTable();
                                    MySqlAdapter.Fill(dataTable);
                                    Result = (object)dataTable;
                                }
                            }
                            else
                            {
                                Result = MySqlCommand.ExecuteNonQuery();
                            }
                        }
                        catch (DbException)
                        {
                            IsFailConn = true;
                        }
                        finally
                        {
                            MySqlCommand.Dispose();
                        }
                    }
                }
                else
                {
                    throw new Exception("No se encuentra la librería " + PathDLL);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog(TypeLog.ERROR, "DBConect.E.006", ex);
            }

            return Result;
        }

        public void Dispose()
        {
            if (_Instance != null)
                _Instance.Dispose();

            GC.Collect();
            GC.SuppressFinalize(this);
        }

        #endregion
    }
}
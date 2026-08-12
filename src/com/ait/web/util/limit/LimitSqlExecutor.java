package com.ait.web.util.limit;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



import com.ait.web.util.limit.dialect.Dialect;
import com.ibatis.sqlmap.engine.execution.SqlExecutor;
import com.ibatis.sqlmap.engine.mapping.statement.MappedStatement;
import com.ibatis.sqlmap.engine.mapping.statement.RowHandlerCallback;
import com.ibatis.sqlmap.engine.scope.StatementScope;

public class LimitSqlExecutor extends SqlExecutor {

	private static final Log logger=LogFactory.getLog(LimitSqlExecutor.class);

	private boolean enableLimit=true;

	private Dialect dialect;

	public boolean isEnableLimit() {
		return enableLimit;
	}

	public void setEnableLimit(boolean enableLimit) {
		this.enableLimit = enableLimit;
	}

	public Dialect getDialect() {
		return dialect;
	}

	public void setDialect(Dialect dialect) {
		this.dialect = dialect;
	}

	@Override
	public void executeQuery(StatementScope request, Connection conn, String sql,
			Object[] parameters, int skipResults, int maxResults, RowHandlerCallback callback)
			throws SQLException {

		if( (skipResults != NO_SKIPPED_RESULTS || maxResults != NO_MAXIMUM_RESULTS) && supportsLimit() )
		{
			sql = dialect.getLimitString(sql, skipResults, maxResults);

			skipResults = NO_SKIPPED_RESULTS;
			maxResults = NO_MAXIMUM_RESULTS;
		}
		logSql(request, sql, parameters);
		super.executeQuery(request, conn, sql, parameters, skipResults, maxResults, callback);
	}

	@Override
	public int executeUpdate(StatementScope request, Connection conn, String sql, Object[] parameters)
			throws SQLException {
		logSql(request, sql, parameters);
		return super.executeUpdate(request, conn, sql, parameters);
	}

	@Override
	public void addBatch(StatementScope request, Connection conn, String sql, Object[] parameters)
			throws SQLException {
		logSql(request, sql, parameters);
		super.addBatch(request, conn, sql, parameters);
	}

	@Override
	public int executeUpdateProcedure(StatementScope request, Connection conn, String sql, Object[] parameters)
			throws SQLException {
		logSql(request, sql, parameters);
		return super.executeUpdateProcedure(request, conn, sql, parameters);
	}

	@Override
	public void executeQueryProcedure(StatementScope request, Connection conn, String sql, Object[] parameters,
			int skipResults, int maxResults, RowHandlerCallback callback) throws SQLException {
		logSql(request, sql, parameters);
		super.executeQueryProcedure(request, conn, sql, parameters, skipResults, maxResults, callback);
	}

	/**
	 * 打印可直接执行的SQL(参数已回填到?位置),并附带对应statement的id和xml文件来源
	 */
	private void logSql(StatementScope request, String sql, Object[] parameters) {
		if (!logger.isDebugEnabled()) {
			return;
		}
		MappedStatement statement = request.getStatement();
		String id = statement != null ? statement.getId() : "unknown";
		String resource = statement != null ? statement.getResource() : "unknown";
		logger.debug("[" + id + "] (" + resource + ") " + bindParameters(sql, parameters));
	}

	private String bindParameters(String sql, Object[] parameters) {
		if (parameters == null || parameters.length == 0) {
			return sql;
		}
		StringBuilder result = new StringBuilder(sql.length() + 32);
		int paramIndex = 0;
		for (int i = 0; i < sql.length(); i++) {
			char c = sql.charAt(i);
			if (c == '?' && paramIndex < parameters.length) {
				result.append(formatParameter(parameters[paramIndex++]));
			} else {
				result.append(c);
			}
		}
		return result.toString();
	}

	private String formatParameter(Object value) {
		if (value == null) {
			return "NULL";
		}
		if (value instanceof Number || value instanceof Boolean) {
			return value.toString();
		}
		if (value instanceof Date) {
			return "'" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((Date) value) + "'";
		}
		return "'" + value.toString().replace("'", "''") + "'";
	}

	public boolean supportsLimit(){
		if(enableLimit&&dialect!=null)
		{
			return dialect.supportsLimit();
		}
		return false;
	}
}

package in.co.rays.proj4.exception;

/**
 * DatabaseException is propogated by DAO classes when an unhandled Database
 * exception occurred
 *
 * @author Aakash Rathod
 *
 */
public class DatabaseException extends Exception{

	 /**
     * @param msg
     *            : Error message
     */
	public DatabaseException(String msg){
		
		super(msg);
	}
}

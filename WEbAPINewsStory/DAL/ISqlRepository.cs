using System.Data.SqlClient;
namespace WEbAPINewsStory.DAL
{
    public interface ISqlRepository
    {
        Task<SqlConnection> GetConnectionAsync();
    }
}

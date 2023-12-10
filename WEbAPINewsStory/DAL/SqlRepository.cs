using Microsoft.AspNetCore.DataProtection.Repositories;
using Microsoft.Extensions.Options;
using System.Data.SqlClient;

namespace WEbAPINewsStory.DAL
{
    public class SqlRepository : ISqlRepository
    {
        private readonly string _ConnectionString;
        public SqlRepository(IOptions<Config> config)
        {
            _ConnectionString = config.Value.ConnectionString;
        }
        public async Task<SqlConnection> GetConnectionAsync()
        {
            var connection = new SqlConnection(_ConnectionString);
            await connection.OpenAsync();
            return connection;
        }
    }
    public class Config
    {
        public string ConnectionString { get; set; }
        public string HangfireConnectionString { get; set; }
        public string SecretKey { get; set; }
        public string LoggingPath { get; set; }

    }
}

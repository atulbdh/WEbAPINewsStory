using System.Data;
using WEbAPINewsStory.Model;
using Dapper;
using System.Data;

namespace WEbAPINewsStory.DAL
{
    public class News : INews
    {
        private readonly ISqlRepository _SqlRepository;
        public News(ISqlRepository SqlRepository)
        {
            _SqlRepository = SqlRepository ?? throw new ArgumentNullException(nameof(SqlRepository));
        }

        public async Task<EntityInfo<IEnumerable<Model.News>>> GetNews(int? PageNumber, int? PageSize, string? WhereCriteria)
        {

            var param = new DynamicParameters();
            param.Add("@PageNumber", PageNumber);
            param.Add("@PageSize", PageSize);
            param.Add("@WhereCrieteria", WhereCriteria);

            using (var connection = await _SqlRepository.GetConnectionAsync())
            {
                using (var multi = connection.QueryMultiple("USP_GetNewsList", param, commandType: CommandType.StoredProcedure))
                {
                    return new EntityInfo<IEnumerable<Model.News>>()
                    {
                        Records = multi.Read<Model.News>(),
                        TotalRecords = multi.Read<int>().First(),
                    };
                }
            }

        }
       
    }
}

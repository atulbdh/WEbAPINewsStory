using WEbAPINewsStory.Model;

namespace WEbAPINewsStory.DAL
{
    public interface INews
    {
        Task<EntityInfo<IEnumerable<Model.News>>> GetNews(int? PageNumber, int? PageSize, string? WhereCriteria);
    }
}

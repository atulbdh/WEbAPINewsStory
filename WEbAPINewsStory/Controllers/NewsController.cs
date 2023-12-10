using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WEbAPINewsStory.DAL;
using WEbAPINewsStory.Model;

namespace WEbAPINewsStory.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class NewsController : ControllerBase
    {
        public readonly INews newsService;
        public NewsController(INews newsService)
        {
            this.newsService = newsService;
        }

        [HttpGet("{PageNumber},{PageSize}")]
        [HttpGet]
        [ProducesResponseType(typeof(EntityInfo<IEnumerable<Model.News>>), 200)]
        public async Task<IActionResult> GetNews(int? PageNumber, int? PageSize, string? WhereCriteria=null)
        {
            var newsobj = await newsService.GetNews(PageNumber, PageSize,  WhereCriteria).ConfigureAwait(false);
            if (newsobj == null || !newsobj.Records.Any())
                return NotFound();
            return Ok(newsobj);
        }
    }
}

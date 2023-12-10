namespace WEbAPINewsStory.Model
{
    public class EntityInfo<T>
    {
        public int TotalRecords { get; set; }
        public T Records { get; set; }
    }
}

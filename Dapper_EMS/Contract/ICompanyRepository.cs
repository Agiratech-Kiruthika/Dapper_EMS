using Dapper_EMS.Entities;

namespace Dapper_EMS.Contract
{
    public interface ICompanyRepository
    {
        public Task<IEnumerable<Company>> GetCompanies();

    }
}

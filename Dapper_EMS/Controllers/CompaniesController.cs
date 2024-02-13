using Dapper_EMS.Contract;
using Microsoft.AspNetCore.Mvc;

namespace Dapper_EMS.Controllers
{
    //[Route("api/companies")]
    //[ApiController]
    public class CompaniesController : Controller
    {
        private readonly ICompanyRepository _companyRepo;

        public CompaniesController(ICompanyRepository companyRepo)
        {
            _companyRepo = companyRepo;
        }

        [HttpGet]
        public async Task<IActionResult> GetCompanies()
        {
            try
            {
                var companies = await _companyRepo.GetCompanies();
                return Ok(companies);
            }
            catch (Exception ex)
            {
                //log error
                return StatusCode(500, ex.Message);
            }
        }
        public async Task<IActionResult> Index()
        {
            var companies = await _companyRepo.GetCompanies();
            return View(companies);
        }
    }
}

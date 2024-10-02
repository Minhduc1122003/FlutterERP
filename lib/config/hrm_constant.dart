const String GLOBAL_URL = 'https://ijtechnology.net/assets/images/api/devkit';
//const String GLOBAL_URL = 'http://192.168.0.4/devkit/assets/images/';

const String SERVER_URL = 'https://ijtechnology.net/api_devkit';
//const String SERVER_URL = 'http://192.168.0.4/devkit/api';

const int statusOk = 200;
const int statusCreated = 201;
const int statusAccepted = 202;
const int statusBadRequest = 400;
const int statusNotAuthorized = 403;
const int statusNotfound = 404;
const int statusInternalError = 500;

const String errorOccured = 'Error occured, please try again later';

const String serverURL = 'http://uat-hrm.reecorp.vn';
const String serverLOCALURL = 'http://localhost:3003';
// Link api-rms.reetech.vn
//const String serverURL = 'http://api-rms.reetech.vn/';

String loginAPI = '$serverURL/hrm/api/userv2/login';
// Link api-rms.reetech.vn
// const String loginAPI = 'http://api-rms.reetech.vn/api/Users/loginv1';

// mduc edit

const String getInfoEmployeeAPI = '$serverURL/hrm/api/Employee/allInfo/';

const String getInfoMobileAPI = '$serverURL/hrm/api/Employee/infoMobile/';
const String GetInsuranceAreaByIdEmployeeAPI =
    '$serverLOCALURL/api/InsuranceArea/GetInsuranceAreaByIdEmployee/';

const String getPositionAPI = '$serverURL/hrm/api/Position/';

// const String getInfoEmployeeAPI = '$serverURL/hrm/api/employee/allInfo/';
const String getListOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine/';
const String getListTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/TimekeepingOffset/getByEmployee/';
const String getListAdvanceRequestAPI = '$serverURL/hrm/api/Reduce/GetAll/';

const String getOnLeaveKindAPI = '$serverURL/hrm/api/permissionType/getAll/';
const String sendOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine';

const String getListShiftModelAPI = '$serverURL/hrm/api/shift/';
const String getListShiftModelByUserAPI =
    '$serverURL/hrm/api/shift/getShiftByDay';
const String sendTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/timekeepingOffset';

const String getAdvanceKindAPI = '$serverURL/hrm/api/ReduceList/GetAll/';
const String sendAdvanceRequestAPI = '$serverURL/hrm/api/Reduce/SaveAll/0';

const String getListAttendanceAPI = '$serverURL/hrm/api/attendance/byEmployee/';
const String getListAttendanceInvalidAPI =
    '$serverURL/hrm/api/attendance/invalid/';
const String getTimeSheetsAPI = '$serverURL/hrm/api/workOfDayAnalysis/total';
const String getOffsetAndOnLeaveAPI =
    '$serverURL/hrm/api/workOfDayAnalysis/summaryOffsets';
const String getListSalaryPeriodAPI = '$serverURL/hrm/api/SalaryPeriod/GetAll/';

const String getSalaryCaculateAPI =
    '$serverURL/hrm/api/SalaryCaculate/GetSalaryByID/';
const String getRegionAPI = '$serverURL/hrm/api/area/';
const String postAddRegionAPI = '$serverURL/hrm/api/area';

const String getBranchAPI = '$serverURL/hrm/api/branch/';
const String postAddBranchAPI = '$serverURL/hrm/api/branch';
const String getLocationAPI = '$serverURL/hrm/api/location/';
const String postCheckInAPI = '$serverURL/hrm/api/attendance/insert/';
const String getScanByDay = '$serverURL/hrm/api/attendance/getScanByDay/';

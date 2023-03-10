const int statusOk = 200;
const int statusCreated = 201;
const int statusAccepted = 202;
const int statusBadRequest = 400;
const int statusNotAuthorized = 403;
const int statusNotfound = 404;
const int statusInternalError = 500;

const String errorOccured = 'Error occured, please try again later';
const String serverURL = 'http://api2.khangthanh.com';

const String loginAPI = '$serverURL/erp/Users/weblogin';
const String getListOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine/';
const String getListTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/TimekeepingOffset/getByEmployee/';
const String getListAdvanceRequestAPI = '$serverURL/hrm/api/Reduce/GetAll/';

const String getOnLeaveKindAPI = '$serverURL/hrm/api/permissionType/getAll/';
const String sendOnLeaveRequestAPI = '$serverURL/hrm/api/onLeaveFileLine';

const String getListShiftModelAPI = '$serverURL/hrm/api/shift/';
const String sendTimekeepingOffsetRequestAPI =
    '$serverURL/hrm/api/timekeepingOffset';

const String getAdvanceKindAPI = '$serverURL/hrm/api/ReduceList/GetAll/';
const String sendAdvanceRequestAPI = '$serverURL/hrm/api/Reduce/SaveAll/0';

const String getListAttendanceAPI = '$serverURL/hrm/api/attendance/ByEmployee/';
const String getListAttendanceInvalidAPI = '$serverURL/hrm/api/attendance/invalid/';
const String getTimeSheetsAPI='$serverURL/hrm/api/workOfDayAnalysis/total';
const String getOffsetAndOnLeaveAPI='$serverURL/hrm/api/workOfDayAnalysis/summaryOffsets';
const String getListSalaryPeriodAPI='$serverURL/hrm/api/SalaryPeriod/GetAll/';


const String getSalaryCaculateAPI='$serverURL/hrm/api/salarycaculate/GetSalaryByID/';



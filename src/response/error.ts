export function errorResponse(res, status,message,errors){
    return res.status(status).json({
        erros: errors,
        message:message,
    });
}
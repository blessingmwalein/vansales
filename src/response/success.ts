export function successResponse(res, status: number,message: string,data: any) {
    return res.status(status).json({
        data: data,
        message:message,
    });
}


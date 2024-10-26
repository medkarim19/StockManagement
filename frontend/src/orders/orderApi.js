import axiosInstance from "axiosApi";

export const getAllProjects = async () => {
    try {
        const response = await axiosInstance.get('projects/');
        return response.data;
    } catch (error) {
        if (error.response && error.response.status === 403) {
            return false;
        } else {
            
            return false;
        }
    }
};


export const getAllOrders = async () => {
    try {
        const response = await axiosInstance.get('orders/');
        return response.data;
    } catch (error) {
        if (error.response && error.response.status === 403) {
            return false;
        } else {
            
            return false;
        }
    }
};

export const getOrderCount = async () => {
    try {
        const response = await axiosInstance.get('orders/count/');
        return response.data.order_count;
    } catch (error) {
        
        return false;
    }
};


export const getOrderCountWithinRange = async (startDate, endDate) => {
    try {
        const response = await axiosInstance.get(`orders/count_within_range/?start_date=${startDate}&end_date=${endDate}`);
        return response.data.order_count_within_range;
    } catch (error) {
        
        return false;
    }
};

export const getMonthlyOrderCount = async () => {
    try {
        const response = await axiosInstance.get('orders/monthly_order_count/');
        return response.data.monthly_order_count;
    } catch (error) {
        
        return false;
    }
};





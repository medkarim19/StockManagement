
import axiosInstance from "axiosApi";

export const addStaff = async (staffData) => {
    try {
        const response = await axiosInstance.post(`email/`, staffData);
        console.log('Email response:', response.data); 
        return response.data; 
    } catch (error) {
        console.error('Error adding a staff account:', error);
        throw error;
    }
};

export const confirmStaff = async (confirmationData) => {
    try {
        const response = await axiosInstance.get(`confirmation/`, { params: confirmationData });
        console.log('Confirmation response:', response.data); 
        return response.data; 
    } catch (error) {
        console.error('Error confirming staff:', error);
        throw error;
    }
};

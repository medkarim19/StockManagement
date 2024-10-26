import axiosInstance from "axiosApi";
import Swal from 'sweetalert2';
import "../assets/css/sweetAlertStyle.css";

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


export const getProjectCountWithinRange = async (startDate, endDate) => {
    try {
        const response = await axiosInstance.get(`projects/count_within_range/?start_date=${startDate}&end_date=${endDate}`);
        return response.data.project_count_within_range;
    } catch (error) {
        
        return false;
    }
};

export const getMonthlyProjectCount = async () => {
    try {
        const response = await axiosInstance.get('projects/monthly_product_count/');
        return response.data.monthly_project_count;
    } catch (error) {
       
        return false;
    }
};


export const getProjectCount = async () => {
    try {
        const response = await axiosInstance.get('projects/count');
        return response.data.project_count;
    } catch (error) {
        
        return false;
    }
};

export const deleteProjectById = async (projectId) => {
    try {
        const response = await axiosInstance.delete(`projects/delete/${projectId}/`);
        return response.data;
    } catch (error) {
        
        if (error.response && error.response.status === 403) {
            Swal.fire({
                icon: 'error',
                title: 'Permission Denied',
                text: 'You do not have permission to delete this project.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        throw error;
    }
};


export const addProject = async (projectData) => {
    try {
        
        const response = await axiosInstance.post(`projects/create`, projectData);
        if (response.status === 201) {
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'Project added successfully!',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        return response.data;
    } catch (error) {
        
        if (error.response && error.response.status === 403) {
            Swal.fire({
                icon: 'error',
                title: 'Permission Denied',
                text: 'You do not have permission to add a project.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        throw error;
    }
};


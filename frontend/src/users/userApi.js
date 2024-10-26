import axiosInstance from "axiosApi";
import Swal from 'sweetalert2';
import "../assets/css/sweetAlertStyle.css";

export const checkSuperuserStatus = async () => {
    try {
        const response = await axiosInstance.get('users/details/');
        
        return response.data.is_superuser === true;
    } catch (error) {
        
        return false;
    }
};

export const checkIsStaffStatus = async () => {
    try {
        const response = await axiosInstance.get('users/details/');
        
        return response.data.is_staff === true;
    } catch (error) {
        
        return false;
    }
};

export const getAllUsers = async () => {
    try {
        const response = await axiosInstance.get('users/');
        return response.data;
    } catch (error) {
        if (error.response && error.response.status === 403) {
            return false;
        } else {
            
            return false;
        }
    }
};

export const getUserCount = async () => {
    try {
        const response = await axiosInstance.get('users/count/');
        return response.data.user_count;
    } catch (error) {

        return false;
    }
};

export const getRegularUserCount = async () => {
    try {
        const response = await axiosInstance.get('users/count_regular_user/');
        return response.data.regular_user_count;
    } catch (error) {

        return false;
    }
};

export const getStaffUserCount = async () => {
    try {
        const response = await axiosInstance.get('users/count_staff_user/');
        return response.data.staff_user_count;
    } catch (error) {
        console.error('Error fetching staff user count:', error);
        return false;
    }
};

export const getUserCountWithinRange = async (startDate, endDate) => {
    try {
        const response = await axiosInstance.get(`users/count_within_range/?start_date=${startDate}&end_date=${endDate}`);
        return response.data.user_count_within_range;
    } catch (error) {
        console.error('Error fetching user count within range:', error);
        return false;
    }
};


export const getUserById = async (userId) => {
    try {
        const response = await axiosInstance.get(`users/${userId}/`);
        return response.data;
    } catch (error) {

        throw error;
    }
};

export const deleteUserById = async (userId) => {
    try {
        const response = await axiosInstance.delete(`users/${userId}/`);
        return response.data;
    } catch (error) {

        throw error;
    }
};

export const updateUserById = async (userId, userData) => {
    try {
        const response = await axiosInstance.put(`users/${userId}/`, userData);
        Swal.fire({
            icon: 'success',
            title: 'Success',
            text: `User with ID ${userId} updated successfully`,
            customClass: {
                container: 'custom-swal-container'
            }
        });
        return response.data;
    } catch (error) {
        console.error('Error updating user by ID:', error);
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Enter a valid email address',
            customClass: {
                container: 'custom-swal-container'
            }
        });
        throw error;
    }
};

export const addUser = async (userData) => {
    try {

        const response = await axiosInstance.post(`users/create`, userData);
        // Check if the response status is 201 (created)
        if (response.status === 201) {
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'User added successfully!',
                customClass: {
                    container: 'custom-swal-container' // Use custom class
                }
            });
        }
        return response.data;
    } catch (error) {

        if (error.response) {
            const errorMessage = error.response.data;
            if (error.response.status === 403) {
                Swal.fire({
                    icon: 'error',
                    title: 'Permission Denied',
                    text: 'You do not have permission to perform this action',
                    customClass: {
                        container: 'custom-swal-container' // Use custom class
                    }
                });
            } else if (errorMessage.email) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: errorMessage.email,
                    customClass: {
                        container: 'custom-swal-container' // Use custom class
                    }
                });
            } else if (errorMessage.password) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: "Password should be at least 8 characters long.",
                    customClass: {
                        container: 'custom-swal-container' // Use custom class
                    }
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'An error occurred while adding the user',
                    customClass: {
                        container: 'custom-swal-container' // Use custom class
                    }
                });
            }
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'An error occurred while adding the user',
                customClass: {
                    container: 'custom-swal-container' // Use custom class
                }
            });
        }
        throw error;
    }
};


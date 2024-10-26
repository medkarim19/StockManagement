import axiosInstance from "axiosApi";
import Swal from 'sweetalert2';
import "../assets/css/sweetAlertStyle.css";

export const getAllProjects = async () => {
    try {
        const response = await axiosInstance.get('projects/');
        return response.data;
    } catch (error) {
        
        return false;
    }
};

export const getAllProducts = async () => {
    try {
        const response = await axiosInstance.get('products/');
        return response.data;
    } catch (error) {
        
        return false;
    }
};

export const getProductCountWithinRange = async (startDate, endDate) => {
    try {
        const response = await axiosInstance.get(`products/count_within_range/?start_date=${startDate}&end_date=${endDate}`);
        return response.data.product_count_within_range;
    } catch (error) {
        
        return false;
    }
};

export const getProductCount = async () => {
    try {
        const response = await axiosInstance.get('products/count/');
        return response.data.product_count;
    } catch (error) {
        
        return false;
    }
};


export const getMonthlyProductCount = async () => {
    try {
        const response = await axiosInstance.get('products/monthly_product_count/');
        return response.data.monthly_product_count;
    } catch (error) {
        
        return false;
    }
};


export const getProductById = async (userId) => {
    try {
        const response = await axiosInstance.get(`products/${userId}/`);
        return response.data;
    } catch (error) {
        
        throw error;
    }
};


export const deleteProductById = async (productId) => {
    try {
        const response = await axiosInstance.delete(`products/${productId}/`);
        return response.data;
    } catch (error) {
        
        if (error.response && error.response.status === 403) {
            Swal.fire({
                icon: 'error',
                title: 'Permission Denied',
                text: 'You do not have permission to delete this product.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'An error occurred while deleting the product.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        throw error;
    }
};


export const addProduct = async (productData) => {
    try {
        const response = await axiosInstance.post(`products/create/`, productData);
        
        if (response.status === 201) {
            Swal.fire({
                icon: 'success',
                title: 'Success',
                text: 'Product added successfully!',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        return response.data;
    } catch (error) {
        
        if (error.response) {
            const responseData = error.response.data;
            if (responseData && responseData.error) {
                const errorMessage = responseData.error;
                // Display specific error messages for product name and quantity
                if (errorMessage === 'No matching product name') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No matching product name.',
                        customClass: {
                            container: 'custom-swal-container'
                        }
                    });
                } else if (errorMessage === 'No matching quantity') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No matching quantity.',
                        customClass: {
                            container: 'custom-swal-container'
                        }
                    });
                } else {
                    // Handle other errors
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: errorMessage,
                        customClass: {
                            container: 'custom-swal-container'
                        }
                    });
                }
            } else if (error.response.status === 403) {
                Swal.fire({
                    icon: 'error',
                    title: 'Permission Denied',
                    text: 'You don\'t have permission to create a product.',
                    customClass: {
                        container: 'custom-swal-container'
                    }
                });
            } else {
                // Handle other errors
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'An error occurred while adding the product.',
                    customClass: {
                        container: 'custom-swal-container'
                    }
                });
            }
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'An error occurred while adding the product.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        throw error;
    }
}


export const updateProductById = async (productId, productData) => {
    try {
        const response = await axiosInstance.put(`products/${productId}/`, productData);
        Swal.fire({
            icon: 'success',
            title: 'Success',
            text: `Product with ID ${productId} updated successfully`,
            customClass: {
                container: 'custom-swal-container'
            }
        });
        return response.data;
    } catch (error) {
        
        if (error.response && error.response.status === 403) {
            Swal.fire({
                icon: 'error',
                title: 'Permission Denied',
                text: 'You do not have permission to update this product.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'An error occurred while updating the product.',
                customClass: {
                    container: 'custom-swal-container'
                }
            });
        }
        throw error;
    }
};


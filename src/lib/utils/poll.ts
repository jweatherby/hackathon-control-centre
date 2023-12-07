const sleep = (duration: number) => new Promise(resolve => setTimeout(resolve, duration))
export const pollAPI = (promiseFn: () => Promise<any>, duration: number): Promise<any> =>
  promiseFn().then(
    sleep(duration).then(() => pollAPI(promiseFn, duration))
  )

// export async function pollAPI(
//   apiCall: () => Promise<any>,
//   interval: number
// ): Promise<any> {
//   return new Promise((resolve, reject) => {
//     try {
//       const fetchData = async () => {
//         try {
//           const data = await apiCall();
//           resolve(data);
//         } catch (error) {
//           reject(error);
//         }
//       };

//       // Polling loop
//       const poll = async () => {
//         try {
//           await fetchData();
//         } catch (error) {
//           console.error('Error fetching data:', error);
//         } finally {
//           setTimeout(poll, interval);
//         }
//       };

//       // Initial call
//       poll();
//     } catch (error) {
//       reject(error);
//     }
//   });
// }

// // Example usage
// async function fetchDataFromAPI() {
//   // Your async API call implementation here
//   const response = await fetch('https://api.example.com/data');
//   if (!response.ok) {
//     throw new Error(`HTTP error! Status: ${response.status}`);
//   }
//   return response.json();
// }

// const pollingInterval = 5000; // in milliseconds

// pollAPI(fetchDataFromAPI, pollingInterval)
//   .then((data) => {
//     console.log('Received data:', data);
//     // Handle received data here
//   })
//   .catch((error) => {
//     console.error('Error polling API:', error);
//   });

/*
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI
import GoogleSignIn

struct VerificationView: View {
  @ObservedObject var authViewModel: AuthenticationViewModel

  var body: some View {
    switch authViewModel.verificationState {
    case .verified(let result):
      VStack {
        Text("List of result object properties:")
          .font(.headline)

        List {
          Text("Access Token: \(result.accessTokenString ?? "Not available")")
          Text("Refresh Token: \(result.refreshTokenString ?? "Not available")")

          if let expirationDate = result.expirationDate {
              Text("Expiration Date: \(formatDateWithDateFormatter(expirationDate))")
          } else {
              Text("Expiration Date: Not available")
          }
        }

        Spacer()
      }
      .navigationTitle(NSLocalizedString("Verified age over 18", comment: "Verified age label"))
    case .unverified:
            ProgressView()
              .navigationTitle(NSLocalizedString("Unverified age over 18",
                                                 comment: "Verified age label"))
    }
  }

  func formatDateWithDateFormatter(_ date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .medium
      dateFormatter.timeStyle = .short
      return dateFormatter.string(from: date)
  }
}

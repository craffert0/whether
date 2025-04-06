// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Dispatch

extension Task {
    @discardableResult
    init<T>(operation: @escaping () async throws -> T,
            queue: DispatchQueue = .main,
            completion: @escaping (Result<T, Error>) -> Void)
        where Success == Void, Failure == any Error
    {
        self.init {
            do {
                let value = try await operation()
                queue.async { completion(.success(value)) }
            } catch {
                queue.async { completion(.failure(error)) }
            }
        }
    }
}
